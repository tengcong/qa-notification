class CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
    @questions = @course.questions.sorted
    @departments=Department.all
  end
end
