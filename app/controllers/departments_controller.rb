class DepartmentsController < ApplicationController

  def index
    @departments=Department.all
  end

  def show
  	
  end

end
