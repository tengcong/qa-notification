class AnswersController < ApplicationController

  def create
    answer = Answer.new params[:answer]
    answer.add_association_to_question params[:question_id]

    notice = create_notice params, answer.user, answer.question.user
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

    notice = create_notice params, answer.user, answer.question.user
    answer.find_related_question_owner.add_new_notice notice

    render :nothing => true
  end

  private

  def create_notice attr, sender, recevier
    notice_attr = { :notice_type => "question",
      :content => attr[:answer][:content],
      :ref_id => attr[:question_id]
    }
    notice = Notice.generate_notice notice_attr, sender, recevier
    notice.save
    notice
  end

end
