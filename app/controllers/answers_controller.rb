class AnswersController < ApplicationController

  def create

    question = Question.find(params[:question_id])
    answer = question.answers.build(params[:answer])
    answer.user = User.find(params[:user_id])

    answer.save

    answer.create_related_notice
    redirect_to(:back)
  end

  def destroy
    answer = Answer.find params[:id]
    answer.destroy
    render :nothing => true
  end

  def update
    answer = Answer.find params[:id]
    answer.update_attributes :content => params[:answer][:content]

    answer.create_related_notice
    render :nothing => true
  end

end
