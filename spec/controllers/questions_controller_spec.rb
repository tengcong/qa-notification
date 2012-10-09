require 'spec_helper'

describe QuestionsController do
  before(:each) do
      # 1.initial test data
      @course = Course.create :name => "aaa"
      @user = User.create :name => 'jerry'

      # 2.test 'test data'
      Course.where(:name => 'aaa').first.should_not be_nil
      User.where(:name => 'jerry').first.should_not be_nil

      # 3.create test parameters and post
      @parameters = {
        :title => "test",
        :content => "test_content",
        :course_id => @course.id,
      }
  end

  describe "POST create" do
    before(:each) do
      post :create, :question => @parameters, :user_id => @user.id
    end
    it "should create questions with user_id and course_id" do
      # 4.test the result
      question = Question.where(:title => 'test').last
      question.should_not be_nil
      question.course.should == @course
      question.user.should == @user

      @user.asked_questions.should be_include question
    end

  end

  describe "GET index" do
    it "should response" do
      user = User.create :name => "test", :role => "student"
      get :index, :user_id => user.id
    end
  end

  describe "DELETE destroy" do
    it "should delete questions" do
      question = Question.new :title => "Q1", :content => "Q1 content"
      question.save
      delete :destroy, :id => question.id
      Question.all.should_not be_include(question)
    end
  end
end
