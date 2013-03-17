class Answer
  include Mongoid::Document

  include Mongoid::Timestamps

  field :content, :type => String
  belongs_to :question
  belongs_to :user

  def add_association_to_question question_id
    self.question = Question.find question_id
    self.question.updated_at = Time.now
    self.question.save
    save
  end

  def find_related_question_owner
    self.question.user
  end

  def answer_creater
    self.user
  end

  def create_related_notice
    if answer_creater != find_related_question_owner
      notice = create_answer_notice answer_creater, find_related_question_owner
      self.find_related_question_owner.add_new_notice notice
    end
  end

  private

  def create_answer_notice sender, recevier
    notice_attr = { :notice_type => "question",
      :content => self.content,
      :ref_id => self.question.id
    }
    notice = Notice.generate_notice notice_attr, sender, recevier
    notice.save
    notice
  end

end
