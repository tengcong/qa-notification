class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :content, :type => String

  has_many :answers
  belongs_to :course
  belongs_to :user

  scope :sorted, desc(:updated_at)

  def self.search_questions query
    query.strip!
    unless query.empty?
      terms =  query.split.join('|')
      Question.where('$or' => [{:title => /#{terms}/i}, {:content => /#{terms}/i}])
    else
      []
    end
  end
end
