class Notice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :read, :type => Boolean, :default => false
  field :notice_type, :type => String
  field :content, :type => String

  belongs_to :user

  class << self
    def generate_notice attr
      Notice.new attr
    end
  end
end
