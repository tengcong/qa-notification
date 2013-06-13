class CoursesController < ApplicationController

  inherit_resources

  belongs_to :major

  def create
    if Course.where(:name => params[:course][:name]).count == 0
      c = Course.new(:name => params[:course][:name])
      c.majors.push Major.find(params[:major_id])
      users = User.where(:major_id => params[:major_id])
      c.save
      users.each do |u|
        u.courses << c
      end
    else
      c = Course.where(:name => params[:course][:name])
      c.majors << Major.find(params[:major_id])
      users.each do |u|
        u.courses << c
      end
    end
    redirect_to root_path
  end

  def show
    @course = Course.find params[:id]
    @questions = @course.questions.sorted
    @departments = Department.all
    @show = true
  end
end
