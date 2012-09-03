class Person
  include Mongoid::Document

  has_many :laptops, :class_name => "Computer"
  has_many :pads, :class_name => "Computer"

  field :name, :type => String
end
