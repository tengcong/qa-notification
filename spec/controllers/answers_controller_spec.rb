require 'spec_helper'

describe AnswersController do

 describe "POST create" do

   it "should create answers with question_id and user_id" do
    user = User.create :name => "kingkong"
    question = Question.create :title => "question title",:content => "question content"

    User.where(:name => "kingkong").first.should_not be_nil
    Question.where(:title => "question title").first.should_not be_nil

    post :create, :user_id => user.id, :question_id => question.id, :content => "answer content"

    answer = Answer.where(:content => "answer content").last

    answer.should_not be_nil
    answer.user.id.should == user.id
    answer.question.id.should == question.id
    question.answers.size.should == 1
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
  it "should update the corresponding answer"  do
    question = Question.create :title => "question title",:content => "question content"
    answer = Answer.create :content => "answer content",  :question_id => question.id
    question.answers.should_not be_empty

    question.answers.should be_include answer

    new_content = "new content"

    origin_updated_at = answer.updated_at
    sleep 1.2

    put :update, :question_id => question.id, :id => answer.id, :answer => {:content => new_content}

    answer.reload.content.should == new_content

    answer.updated_at.should > origin_updated_at
  end
 end
end
