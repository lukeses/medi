class VisitsController < ApplicationController
  before_action :set_visit, only: [:show, :edit, :update, :destroy]

  # GET /visits
  # GET /visits.json
  def index
    @visits = Visit.all
  end

  # GET /visits/1
  # GET /visits/1.json
  def show
  end

  # GET /visits/new
  def new
    # @visit = Visit.new
    # @clinics = Clinic.all
    # @doctors = Doctor.where(id: Clinic.first.works.pluck(:doctor_id))
    # how_many_visits = (Work.last.workhours.where(weekday: 6).first.finish -  Work.last.workhours.where(weekday: 6).first.start) / 30.minutes
    # @possible_visits = Array.new

    # for i in 0..how_many_visits-1 do
    #   @possible_visits << [i, Work.last.workhours.where(weekday: 6).first.start + i*30.minutes ]
    # end


    @visit = Visit.new
    @clinics = Clinic.all
    @selected_clinic = Clinic.first
    works = Work.where(clinic_id: @selected_clinic)
    @doctors = Doctor.where(id: works.pluck(:doctor_id))
    
#     puts @doctors.inspect

    date = DateTime.now.beginning_of_day

    # selected_works = Work.where(clinic_id: params[:clinic_id], doctor_id: params[:doctor_id])

    puts "################"
    selected_works = Work.where(clinic_id: @selected_clinic.id, doctor_id: @doctors.first).pluck(:id)
    @workhours = Workhour.where(work_id: selected_works, weekday: date.wday)
    @possible_visits = Array.new

    @workhours.each do |workhour|
      puts workhour.inspect
      how_many_visits = (workhour.finish - workhour.start) / 30.minutes
      for i in 0..how_many_visits-1 do
        @possible_visits << [i, workhour.start + i*30.minutes]
      end
    end




  end

  # GET /visits/1/edit
  def edit
  end

  # POST /visits
  # POST /visits.json
  def create
    @visit = Visit.new(visit_params)

    respond_to do |format|
      if @visit.save
        format.html { redirect_to @visit, notice: 'Visit was successfully created.' }
        format.json { render :show, status: :created, location: @visit }
      else
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
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to visits_url, notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_visits
    @clinics = Clinic.all
    @selected_clinic = Clinic.find(params[:clinic_id])
    works = Work.where(clinic_id: @selected_clinic)
    @doctors = Doctor.where(id: works.pluck(:doctor_id))
    
#     puts @doctors.inspect

    date = DateTime.new(params[:date_year].to_i, params[:date_month].to_i, params[:date_day].to_i)

    # selected_works = Work.where(clinic_id: params[:clinic_id], doctor_id: params[:doctor_id])

    puts "################"
    selected_works = Work.where(clinic_id: params[:clinic_id], doctor_id: params[:doctor_id]).pluck(:id)
    @workhours = Workhour.where(work_id: selected_works, weekday: date.wday)
    @possible_visits = Array.new

    @workhours.each do |workhour|
      puts workhour.inspect
      how_many_visits = (workhour.finish - workhour.start) / 30.minutes
      for i in 0..how_many_visits-1 do
        @possible_visits << [i, workhour.start + i*30.minutes]
      end
    end


    # @workhours = Array.new
    # selected_works.each do |work|
    #   work.workhours .each do |workhour|
    #     @workhours << work
    #     puts workhour.inspect
    #   end
    # end
 puts "################"

 @doctor_id = params[:doctor_id]
 puts "Doktor ID: #{@doctor_id}"
    #how_many_visits = (Work.where(clinic_id: @selected_clinic, doctor_id: @doctors.first).first.workhours.where(weekday: date.wday).first.finish -  Work.where(clinic_id: @selected_clinic, doctor_id: @doctors.first).first.workhours.where(weekday: date.wday).first.finish) / 30.minutes
# puts 'ile wizyt'
# puts how_many_visits
#     @possible_visits = Array.new

#     for i in 0..how_many_visits-1 do
#       @possible_visits << [i, Work.last.workhours.where(weekday: 6).first.start + i*30.minutes ]
#     end
    respond_to do |format|
      format.js
    end
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
