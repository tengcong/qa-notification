class Department
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  has_many :majors
  has_many :students
end
