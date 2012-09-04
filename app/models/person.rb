class Person
  include Mongoid::Document

  has_many :laptops, :class_name => "Computer"
  has_many :pads, :class_name => "Computer"

  field :name, :type => String
end

=begin
class Person
  include Mongoid::Document
  has_many :laptops, :class_name => "Computer"
  has_many :pads, :class_name => "Computer"

  field :name, :type => String
end

====

class Computer
  include Mongoid::Document
    belongs_to :borrower, :class_name => "Person"
    belongs_to :lender, :class_name => "Person"
    field :name, :type => String
end

----

lender = Person.create :name => "lender"
borrower = Person.create :name => "borrower"

laptop = Computer.create :name => "laptop"
ipad = Computer.create :name => "ipad"

lender.laptops << laptop

	MONGODB (0ms) notification_development['computers'].update({"_id"=>BSON::ObjectId('5044231dc3666e7194000003')}, {"$set"=>{"borrower_id"=>BSON::ObjectId('5044231dc3666e7194000001')}})

lender.pads << ipad
	MONGODB (0ms) notification_development['computers'].update({"_id"=>BSON::ObjectId('5044231dc3666e7194000004')}, {"$set"=>{"borrower_id"=>BSON::ObjectId('5044231dc3666e7194000001')}})

lender.laptops
 	=> [#<Computer _id: 5044231dc3666e7194000003, _type: nil, borrower_id: BSON::ObjectId('5044231dc3666e7194000001'), lender_id: nil, name: "laptop">]

 	MONGODB (0ms) notification_development['computers'].find({"person_id"=>BSON::ObjectId('5044231dc3666e7194000001')})

 lender.pads
 	=> [#<Computer _id: 5044231dc3666e7194000004, _type: nil, borrower_id: BSON::ObjectId('5044231dc3666e7194000001'), lender_id: nil, name: "ipad">]

 	MONGODB (0ms) notification_development['computers'].find({"person_id"=>BSON::ObjectId('5044231dc3666e7194000001')})

borrower.laptops
 	=> []
 	MONGODB (0ms) notification_development['computers'].find({"person_id"=>BSON::ObjectId('5044231dc3666e7194000002')})

---------------------------
wrong:

 laptop.lender
 => nil

 laptop.borrower
 => #<Person _id: 5044231dc3666e7194000001, _type: nil, name: "lender">

 ipad.lender
 => nil

 ipad.borrower
 => #<Person _id: 5044231dc3666e7194000001, _type: nil, name: "lender">

 -----------------
 after reload

 lender.reload
 borrower.reload
 laptop.reload
 ipad.reload


lender.pads
 => []
 MONGODB (0ms) notification_development['computers'].find({"person_id"=>BSON::ObjectId('5044231dc3666e7194000001')})

 borrower.pads
 => []
 MONGODB (0ms) notification_development['computers'].find({"person_id"=>BSON::ObjectId('5044231dc3666e7194000002')})

 laptop.lender
 => nil
 laptop.borrower
 => #<Person _id: 5044231dc3666e7194000001, _type: nil, name: "lender


===============Fix================



=end
