class Student < User
  has_and_belongs_to_many :majors
  belongs_to :department
end
