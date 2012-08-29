require 'spec_helper'

describe AnswersController do


  describe "POST create" do

    before(:each) do
      @asker = User.create :name => "tom"
      @answerer = User.create :name => "kingkong"

      @question = Question.create :title => "question title",:content => "question content", :user_id => @asker.id

      User.where(:name => "kingkong").first.should_not be_nil
      Question.where(:title => "question title").first.should_not be_nil

    end

    it "should create answers with question_id and user_id" do
      post :create, :user_id => @answerer.id, :question_id => @question.id, :content => "answer content"
      answer = Answer.where(:content => "answer content").last
      answer.should_not be_nil
      answer.user.id.should == @answerer.id
      answer.question.id.should == @question.id
      @question.answers.size.should == 1
    end

    it "should create a notification to questions's ower" do
      origin_notices = @asker.notices
      origin_notices_size = origin_notices.size
      post :create, :user_id => @answerer.id, :question_id => @question.id, :content => "answer content"

      @asker.reload
      new_notices = @asker.notices
      new_notices.size.should == (origin_notices_size + 1)

      notice = new_notices.last

      notice.notice_type.should == "question"
      notice.content.should == @question.id.to_s
      notice.read.should == false
    end
  end
end
