require 'spec_helper'

describe Notice do

  before(:each) do
    @sender = User.where(:name => 'sender').first ||
              User.create(:name => "sender", :email => '12@12.com')
    @receiver = User.where(:name => 'receiver').first ||
              User.create(:name => "receiver", :email => '34@12.com')
    @question = Question.create :title => "a new question"

    @notice_attr = {
      :notice_type => "question",
      :content => "test content",
      :ref_id => @question.id.to_s
    }
    @notice = Notice.generate_notice @notice_attr, @sender, @receiver
    @notice.save
    @notice.reload
  end

  describe ".generate_notice" do
    it "should generate right kind of notice with params" do
      @notice.find_sender.should == @sender
      @notice.find_receiver.should == @receiver
    end
  end

  describe "#find_ref_object" do
    it "should return the origin object of the notice" do
      @question.should == @notice.find_ref_object
    end
  end

  describe ".sorted" do
    it "should return all notification" do
      selected_notices = Notice.sorted
      selected_notices.all.should == selected_notices.sort_by(&:updated_at).reverse
    end
  end

  describe ".unread" do
    it "should return all unread notifications" do
      selected_notices = Notice.unread
      selected_notices.map(&:unread).sum.should == selected_notices.size
    end
  end

  describe "#read" do
    it "should change notice unread status from 1 to 0" do
      @notice.unread.should == 1
      @notice.readed
      @notice.reload
      @notice.unread.should == 0
    end
  end

end
