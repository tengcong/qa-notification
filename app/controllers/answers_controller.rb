class AnswersController < ApplicationController

  def create
    answer = Answer.new params[:answer]
    answer.add_association_to_question params[:question_id]

    answer.create_related_notice params
    render :nothing => true
  end

  def destroy
    answer = Answer.find params[:id]
    answer.destroy
    render :nothing => true
  end

  def update
    answer = Answer.find params[:id]
    answer.update_attributes :content => params[:answer][:content]

    answer.create_related_notice params
    render :nothing => true
  end

end
