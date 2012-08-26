class AnswersController < ApplicationController

  def create
    answer = Answer.new params
    answer.add_association_to_question params[:question_id]
    answer.save
    render :nothing => true
  end

end
