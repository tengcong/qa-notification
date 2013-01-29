class Question
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,       :type => String
  field :content,     :type => String
  field :click_rate, :type => Integer, :default => 0

  has_many :answers
  belongs_to :course
  belongs_to :user

  scope :sorted, desc(:updated_at)

  def self.hot_question
    self.desc("click_rate").limit(5).to_a
  end

  def self.search_questions query
    query.strip!
    unless query.empty?
      terms =  query.split.join('|')
      Question.where('$or' => [{:title => /#{terms}/i}, {:content => /#{terms}/i}])
    else
      []
    end
  end

  def incr_visitation
    self.click_rate += 1
    save
  end
end
