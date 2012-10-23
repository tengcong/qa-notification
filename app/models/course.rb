class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  has_and_belongs_to_many :majors
  has_many :questions

  has_and_belongs_to_many :users

end
