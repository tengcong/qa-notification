class Notice
  include Mongoid::Document


  field :readed, :type => Boolean, :default => false

  belongs_to :user

end
