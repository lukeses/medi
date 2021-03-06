class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /visits
  # GET /visits.json
  def index
    if current_user.admin?
      @visits = Visit.where(["patient_id IS NOT NULL"])
    else
      @visits = Visit.where(patient_id: current_user.patient.id)
    end
  end

  def index_visits_for_doctor
    @visits = Visit.where(doctor_id: current_user.doctor.id, confirmed: true)
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    @visit = Visit.new
    @clinics = Clinic.all
    @selected_clinic = Clinic.first
    works = Work.where(clinic_id: @selected_clinic)
    @doctors = Doctor.where(id: works.pluck(:doctor_id))
    
    @possible_visits = Visit.where(clinic_id: Clinic.first, doctor_id: @doctors.first, start: DateTime.now..DateTime.now+30.days) 
  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)
    time = DateTime.parse(params[:visit_start])
    @visit.start = DateTime.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i, time.strftime('%H').to_i, time.strftime('%M').to_i)
    @visit.finish = @visit.start + 30.minutes
    @visit.patient = current_user.patient
    @visit.confirmed = false

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: 'Visit was successfully created.' }
        format.json { render :show, status: :created, location: @visit }
      else
        set_before_not_valid
        format.html { render :new }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # PATCH/PUT /visits/1
  # PATCH/PUT /visits/1.json
  def update
    respond_to do |format|
      if @visit.update(visit_params)
        format.html { redirect_to @visit, notice: 'Visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @visit }
      else
        format.html { render :edit }
        format.json { render json: @visit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /visits/1
  # DELETE /visits/1.json
  def destroy
    if @visit.start > DateTime.now
      @visit.destroy
    else
      flash[:notice] = "You can't delete past visit."
    end

    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_visits
    date = DateTime.new(params[:date_year].to_i, params[:date_month].to_i, params[:date_day].to_i)
    @possible_visits = Visit.where(start: date.beginning_of_day..date.end_of_day, clinic_id: params[:clinic_id], doctor_id: params[:doctor_id]).where(["patient_id IS NULL"])
    @selected_clinic = Clinic.find(params[:clinic_id])
    works = Work.where(clinic_id: @selected_clinic)
    @doctors = Doctor.where(id: works.pluck(:doctor_id))
    @doctor_id = params[:doctor_id]

    respond_to do |format|
      format.js
    end
  end

  def set_before_not_valid
    #@visit = Visit.new
    @clinics = Clinic.all
    @selected_clinic = Clinic.first
    works = Work.where(clinic_id: @selected_clinic)
    @doctors = Doctor.where(id: works.pluck(:doctor_id))

    date = DateTime.now.beginning_of_day

    selected_works = Work.where(clinic_id: @selected_clinic.id, doctor_id: @doctors.first).pluck(:id)
    @workhours = Workhour.where(work_id: selected_works, weekday: date.wday)
    @possible_visits = Array.new

    @workhours.each do |workhour|
      puts workhour.inspect
      how_many_visits = (workhour.finish - workhour.start) / 30.minutes
      for i in 0..how_many_visits-1 do
        start_date_to_check = date.change(hour: workhour.start.hour, min: workhour.start.min)
        @possible_visits << [i, workhour.start + i*30.minutes] unless Visit.exists?(clinic_id: @selected_clinic.id, doctor_id: @doctors.first, start: start_date_to_check)
      end
    end
  end


  def toggle_confirm  
    @visit_to_confirm = Visit.find(params[:id])  
    @visit_to_confirm.toggle!(:confirmed) if @visit_to_confirm.confirmed == false
    redirect_to :visits, :action => "index"
  end

  def book 
    @visit_to_book = Visit.find(params[:id])  
    if @visit_to_book.patient.nil?
      @visit_to_book.patient = current_user.patient
    else
      flash[:notice] = "Someone reserved this visit earlier"
    end
    @visit_to_book.save
    redirect_to :visits, :action => "index"
  end


  def new_first_clinic
    @visit = Visit.new
    @clinics = Clinic.all
    @selected_clinic = Clinic.first
  end

  def create_first_clinic
    @visit_to_book = Visit.where(['start > ?', DateTime.now]).where(clinic_id: params[:visit][:clinic_id]).where(["patient_id IS NULL"]).order(:start).first
    if @visit_to_book.nil?
      flash[:notice] = "Choose another clinic"
    elsif @visit_to_book.patient.nil?
      @visit_to_book.patient = current_user.patient
      @visit_to_book.save
    else
      flash[:notice] = "Someone reserved this visit earlier"
    end
    redirect_to :visits, :action => "index"
  end

  def new_first_doctor
    @visit = Visit.new
    @doctors = Doctor.all
  end

  def create_first_doctor
    @visit_to_book = Visit.where(['start > ?', DateTime.now]).where(doctor_id: params[:visit][:doctor_id]).where(["patient_id IS NULL"]).order(:start).first
    if @visit_to_book.nil?
      flash[:notice] = "Choose another doctor"
    elsif @visit_to_book.patient.nil?
      @visit_to_book.patient = current_user.patient
      @visit_to_book.save
    else
      flash[:notice] = "Someone reserved this visit earlier"
    end
    redirect_to :visits, :action => "index"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visit_params
      params.require(:visit).permit(:datetime, :datetime, :patient_id, :doctor_id, :clinic_id, :confirmed)
    end
end
