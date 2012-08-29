class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, :type => String
  belongs_to :question
  belongs_to :user

  def add_association_to_question question_id
    question = Question.find question_id
    save
  end

  def find_related_question_owner
    self.question.user
  end
end
