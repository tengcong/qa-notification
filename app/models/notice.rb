class Notice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :notice_type, :type => String
  field :content, :type => String

  field :ref_id, :type => String

  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"

  class << self
    def generate_notice attr, s, r
      notice = Notice.new attr
      notice.sender, notice.receiver = s, r
      notice
    end
  end

  def find_ref_object
    notice_type.capitalize.constantize.find ref_id
  end

end
