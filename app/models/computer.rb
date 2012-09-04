class Computer
  include Mongoid::Document
    belongs_to :borrower, :class_name => "Person"
    belongs_to :lender, :class_name => "Person"
    belongs_to :user
    field :name, :type => String
end
