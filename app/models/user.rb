class User
  include Mongoid::Document
  field :name, type: String
  field :role, type: String
  has_many :questions
  has_and_belongs_to_many :courses
  has_many :answers


  def lastest_question_of_my_courses
    desc_list_by_updated_at courses.map(&:questions).flatten
  end
end

