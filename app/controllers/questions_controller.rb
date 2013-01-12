class QuestionsController < ApplicationController

  def create
    question = Question.create params[:question]
    user = User.find params[:question][:user]
    user.add_asked_questions question
    redirect_to :back
  end

  def show
    @question = Question.find params[:id]
    @departments = Department.all
  end

  def index
    user = User.find params[:user_id]
    @questions = user.lastest_question_of_my_courses
  end

  def destroy
    question = Question.find params[:id]
    question.destroy
    render :nothing => true
  end
end
