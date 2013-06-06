class MajorsController < ApplicationController

  inherit_resources
  belongs_to :department

  def show
    @major = Major.find params[:id]
    @departments = Department.all
    @courses = @major.courses

  end
end
