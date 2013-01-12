class DepartmentsController < ApplicationController

  def index
    @departments=Department.all
  end

  def show

  end

  def get_majors
    @majors = Department.find(params[:d_id]).majors
    render :layout => false
  end

end
