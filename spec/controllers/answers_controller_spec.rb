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
      post :create, :question_id => @question.id, :answer => {:content => "answer content", :user_id => @answerer.id}
      answer = Answer.where(:content => "answer content").last
      answer.should_not be_nil
      answer.user.id.should == @answerer.id
      answer.question.id.should == @question.id
      @question.answers.size.should == 1
    end

    it "should create a notification to questions's ower" do
      origin_notices = @asker.notices
      origin_notices_size = origin_notices.size
      post :create, :question_id => @question.id, :answer => {:content => "answer content", :user_id => @answerer.id}

      @asker.reload
      new_notices = @asker.notices

      new_notices.size.should == (origin_notices_size + 1)

      notice = new_notices.last
      notice.notice_type.should == "question"

      notice.content.should == "answer content"
      notice.ref_id.should == @question.id.to_s
    end
 end

 describe "DELETE destroy" do
   it "should destroy the corresponding answer" do
    question = Question.create :title => "question title",:content => "question content"
    answer = Answer.create :content => "answer content",  :question_id => question.id

    question.answers.should_not be_empty

    question.answers.should be_include answer

    delete :destroy, :question_id => question.id, :id => answer.id

    question.reload

    question.answers.should_not be_include answer

    end
 end

 describe "PUT update" do

  before(:each) do
      @asker = User.create :name => "tom"
      @answerer = User.create :name => "kingkong"

      @question = Question.create :title => "question title",:content => "question content", :user_id => @asker.id

      User.where(:name => "kingkong").first.should_not be_nil
      Question.where(:title => "question title").first.should_not be_nil
  end

  it "should update the corresponding answer and create a notification to question owner" do
    answer = Answer.create :user_id => @answerer.id, :content => "answer content",  :question_id => @question.id
    @question.answers.should_not be_empty

    @question.answers.should be_include answer

    new_content = "new content"

    origin_updated_at = answer.updated_at
    sleep 1.2

    put :update, :question_id => @question.id, :id => answer.id, :answer => {:content => new_content}

    answer.reload.content.should == new_content

    answer.updated_at.should > origin_updated_at

  end

  it "should create a notification to questions's ower" do
      answer = Answer.create :user_id => @answerer.id, :content => "answer content",  :question_id => @question.id

      origin_notices = @asker.notices
      origin_notices_size = origin_notices.size

      put :update, :question_id => @question.id, :id => answer.id, :answer => {:content => "new_content"}

      @asker.reload

      new_notices = @asker.notices
      new_notices.size.should == (origin_notices_size + 1)

      notice = new_notices.last

      notice.notice_type.should == "question"
      notice.content.should == "new_content"
      notice.ref_id.should == @question.id.to_s
  end
 end
end
