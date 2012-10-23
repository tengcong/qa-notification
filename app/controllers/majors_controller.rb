class MajorsController < ApplicationController
  def show
    @major = Major.find params[:id]
    @courses = @major.courses
    render :text => "#{@major.name} : " << @courses.map(&:name).join('-')
  end
end
