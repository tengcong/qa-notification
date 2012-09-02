class AnswersController < ApplicationController

  def create
    answer = Answer.new params
    answer.add_association_to_question params[:question_id]

    notice = create_notice params
    answer.find_related_question_owner.add_new_notice notice

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

    notice = create_notice params
    answer.find_related_question_owner.add_new_notice notice

    render :nothing => true
  end

  private

  def create_notice params
    notice_attr = {:notice_type => "question", :content => params[:question_id]}
    Notice.generate_notice notice_attr
  end

end
