class Notice
  include Mongoid::Document
  include Mongoid::Timestamps

  field :notice_type, :type => String
  field :content, :type => String

  field :ref_id, :type => String

  # 1 means unread
  # 0 means read
  field :unread, :type => Integer, :default => 1

  belongs_to :sender, :class_name => "User"
  belongs_to :receiver, :class_name => "User"


  # 按updated时间倒叙
  scope :sorted, desc(:updated_at)
  # 所有未读
  scope :unread, where(:unread => 1)

  def find_sender
    self.reload.sender
  end

  def find_receiver
    self.reload.receiver
  end

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

  def readed
    self.unread = 0
    save
  end

end
