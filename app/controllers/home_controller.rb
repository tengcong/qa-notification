class HomeController < ApplicationController

  def index
    @departments = Department.all
    if current_user
      @questions = current_user.lastest_question_of_my_courses
      @questions_notices = current_user.list_questions_notices
    else
      @questions = Question.desc(:updated_at)
    end
    @hot_courses = Course.hot_course
  end

end
