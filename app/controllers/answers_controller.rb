class AnswersController < ApplicationController

  def create
    answer = Answer.new params
    answer.add_association_to_question params[:question_id]
    notice_attr = {:notice_type => "question", :content => params[:question_id]}

    user = answer.find_related_question_owner
    notice = Notice.generate_notice notice_attr
    user.add_new_notice notice

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
