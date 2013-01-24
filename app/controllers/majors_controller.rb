class MajorsController < ApplicationController
  def show
    @major = Major.find params[:id]
    @departments = Department.all
    @courses = @major.courses
  end
end
