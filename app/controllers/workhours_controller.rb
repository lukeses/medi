class WorkhoursController < ApplicationController
  before_action :set_workhour, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /workhours
  # GET /workhours.json
  def index
    works = Work.where(doctor_id: current_user.doctor.id)
    @workhours = Workhour.where(work_id: works.pluck(:id))
  end

  # GET /workhours/1
  # GET /workhours/1.json
  def show
  end

  # GET /workhours/new
  def new
    @workhour = Workhour.new
    @works = Work.where(doctor_id: current_user.doctor.id)
    @weekdays = {:monday=>1, :tuesday=>2, :wednesday=>3, :thursday=>4, :friday=>5, :saturday=>6, :sunday=>0}
  end

  # GET /workhours/1/edit
  def edit
  end

  # POST /workhours
  # POST /workhours.json
  def create
    @workhour = Workhour.new(workhour_params)
    @workhour.start = @workhour.start.change(day: 1, month: 1, year: 2000)
    @workhour.finish = @workhour.finish.change(day: 1, month: 1, year: 2000)
    # @workhour.start = DateTime.new(hour: params[:workhour]['start(4i)'].to_i, min: params[:workhour]['start(5i)'].to_i)
    # @workhour.finish = DateTime.new(hour: params[:workhour]['finish(4i)'].to_i, min: params[:workhour]['finish(5i)'].to_i)

# puts WorkhoursHelper::date_from_date_select_params(params[:workhour], :start)
# puts WorkhoursHelper::date_from_date_select_params(params[:workhour], :finish)

    respond_to do |format|
      if @workhour.save
        format.html { redirect_to @workhour, notice: 'Workhour was successfully created.' }
        format.json { render :show, status: :created, location: @workhour }
      else
        @works = Work.where(doctor_id: current_user.doctor.id)
        @weekdays = {:monday=>1, :tuesday=>2, :wednesday=>3, :thursday=>4, :friday=>5, :saturday=>6, :sunday=>0}
        format.html { render :new }
        format.json { render json: @workhour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workhours/1
  # PATCH/PUT /workhours/1.json
  def update
    respond_to do |format|
      if @workhour.update(workhour_params)
        format.html { redirect_to @workhour, notice: 'Workhour was successfully updated.' }
        format.json { render :show, status: :ok, location: @workhour }
      else
        format.html { render :edit }
        format.json { render json: @workhour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workhours/1
  # DELETE /workhours/1.json
  def destroy
    @workhour.destroy
    respond_to do |format|
      format.html { redirect_to workhours_url, notice: 'Workhour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workhour
      @workhour = Workhour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workhour_params
      params.require(:workhour).permit(:weekday, :start, :finish, :work_id)
    end
end
