class Admin::StudentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to admin_students_url, notice: "student was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to admin_students_url, notice: "student was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to admin_students_url, notice: "student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import_csv
    if params[:file].present?
      Student.import_csv(params[:file])
      redirect_to admin_students_path, notice: 'CSV file imported successfully.'
    else
      redirect_to admin_students_path, alert: 'Please choose a CSV file to import.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      if params[:action] == 'create'
        params.permit(:name,:email,:varified,:address,:date_of_birth,:password) 
      else
        params.permit(:name,:email,:varified,:address,:date_of_birth);
      end
    end
    
end
        