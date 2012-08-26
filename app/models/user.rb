class User
  include Mongoid::Document
  field :name, type: String
  field :role, type: String

  has_many :questions
end
