class User
  include Mongoid::Document
  field :name, type: String
  field :role, type: String
  has_many :asked_questions, :class_name => "Question"
  has_and_belongs_to_many :courses
  has_many :answers


  def lastest_question_of_my_courses
    desc_list_by_updated_at courses.map(&:questions).flatten
  end

  def add_asked_questions question
    asked_questions << question
    save
  end

end

