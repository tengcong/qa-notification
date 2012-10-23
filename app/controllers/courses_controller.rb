class CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
    @questions = @course.questions.sorted
    render :text => "#{@course.name} --- </br>" << @questions.map(&:title).join('</br>')
  end
end
