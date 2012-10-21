class HomeController < ApplicationController

  def index
    @departments = Department.all
    if current_user
      login_user_home
    else
      guest_home
    end
  end

  private
  def login_user_home
    @current_user = current_user
    @questions = @current_user.lastest_question_of_my_courses
    @questions_notices = @current_user.list_questions_notices
  end

  def guest_home
    @questions = Question.all
  end
end
