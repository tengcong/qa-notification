class Major
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  belongs_to :department
  has_and_belongs_to_many :courses

  def find_all_related_questions
    courses.map(&:questions).flatten
  end
end
