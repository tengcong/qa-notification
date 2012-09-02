require 'spec_helper'

describe Notice do

  before(:each) do
      @sender = User.create :name => "sender"
      @receiver = User.create :name => "receiver"
      @question = Question.create :title => "a new question"

      @notice_attr = {
        :notice_type => "question",
        :content => "test content",
        :ref_id => @question.id.to_s
      }
      @notice = Notice.generate_notice @notice_attr, @sender, @receiver
  end

  describe ".generate_notice" do
    it "should generate right kind of notice with params" do
      @notice.sender.should == @sender
      @notice.user.should == @receiver
    end
  end

  describe "#find_ref_object" do
    it "should return the origin object of the notice" do
      @question.should == @notice.find_ref_object
    end
  end

end
