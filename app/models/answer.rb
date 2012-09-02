class Answer
  include Mongoid::Document

  include Mongoid::Timestamps

  field :content, :type => String
  belongs_to :question
  belongs_to :user

  def add_association_to_question question_id
    self.question = Question.find question_id
    save
  end

  def find_related_question_owner
    self.question.user
  end

  def answer_creater
    self.user
  end

  def create_related_notice attr
    notice = create_answer_notice attr, answer_creater, find_related_question_owner
    self.find_related_question_owner.add_new_notice notice
  end

  private

  def create_answer_notice attr, sender, recevier
    notice_attr = { :notice_type => "question",
      :content => attr[:answer][:content],
      :ref_id => attr[:question_id]
    }
    notice = Notice.generate_notice notice_attr, sender, recevier
    notice.save
    notice
  end

end
