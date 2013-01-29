class HomeController < ApplicationController

  def index
    @departments = Department.all
    if current_user
      @questions = current_user.lastest_question_of_my_courses
      @questions_notices = current_user.list_questions_notices

      @hot_questions = Course.hot_course
    else
      @questions = Question.all
    end
  end

end
