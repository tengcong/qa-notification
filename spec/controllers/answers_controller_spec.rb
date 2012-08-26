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
end
