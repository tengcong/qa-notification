class Student < User
  field :username, :type => "String"
  field :password, :type => "String"
  field :email, :type => "String"

  has_and_belongs_to_many :majors
  belongs_to :department
end
