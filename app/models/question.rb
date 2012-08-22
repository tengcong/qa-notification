class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :content, :type => String
  has_many :answers
  belongs_to :course
end
