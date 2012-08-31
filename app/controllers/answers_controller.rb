class AnswersController < ApplicationController

  def create
    answer = Answer.new params
    answer.add_association_to_question params[:question_id]
    answer.save
    render :nothing => true
  end
  
  def destroy
    answer = Answer.find params[:id]
    answer.destroy
    render :nothing => true
  end


  def update
    answer = Answer.find params[:id]
    answer.content = params[:answer][:content]
    answer.save
    render :nothing => true
  end

end
