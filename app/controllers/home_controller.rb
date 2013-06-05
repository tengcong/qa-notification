#encoding: utf-8
class HomeController < ApplicationController

  def index
    @departments = Department.all
    if current_user
      @questions = current_user.lastest_question_of_my_courses
      @questions_notices = current_user.list_questions_notices
    else
      @questions = Question.desc(:updated_at)
    end

    render :layout => false
    # @hot_courses = Course.hot_course
  end

  def mail_to_students
    flash[:success] = '发送成功！'
    ResourcesMailer.send_to_students(current_user, params[:resource][:subject], params[:resource][:content])
    redirect_to root_path
  end

end
