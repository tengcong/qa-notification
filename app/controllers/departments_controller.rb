class DepartmentsController < ApplicationController

  def index
    @departments=Department.all
  end

  def show
    @departments = Department.all
    @department = Department.find(params[:id])
    @majors = @department.majors
  end

  def get_majors
    @majors = Department.find(params[:d_id]).majors
    render :layout => false
  end

end
