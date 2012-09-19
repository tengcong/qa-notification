require 'spec_helper'

describe User do
  before(:each) do
    @tommy = User.create :name => 'tommy', :role => "student"
    generate_courses_with_questions_for @tommy
  end

  describe "#lastest_question_of_my_courses" do
    it "should return all courses questions" do
      questions = @tommy.lastest_question_of_my_courses
      questions.size.should == 3

      (questions.map(&:title) - %w-mq1 mq2 eq1-).should == []

    end
    it "should return right order of questions" do
      origin_questions = []
      @tommy.courses.map(&:questions).flatten.each do |q|
        origin_questions << q
      end

      origin_questions.each do |q|
        q.updated_at = Time.now
        sleep 1.0
      end


      # 1. edit question_2 then it should be before question_1
      # 2. query all question with right order

      # 1
      questions = @tommy.lastest_question_of_my_courses

      questions.should == questions.sort_by(&:updated_at).reverse
    end
  end

  describe "#list_questions_notices" do
    before(:each) do
      @q1 = Question.create :user => @tommy
      sleep 1.0
      @q2 = Question.create :user => @tommy

      user = User.create

      answer1 = user.answers.build
      answer1.question = @q1
      answer1.save

      answer2 = user.answers.build
      answer2.question = @q2
      answer2.save
      answer2.create_related_notice
      sleep 1.0
      answer1.create_related_notice

      @q1.answers = [answer1]
      @q2.answers = [answer2]
      @tommy.asked_questions = [@q1, @q2]
      @tommy.save
    end
    it "should return related questions" do

      questions_with_answers = @tommy.asked_questions.select{|q| !q.answers.empty?}
      notices_questions = @tommy.list_questions_notices
      notices_questions.size.should == questions_with_answers.size
      (notices_questions - questions_with_answers).should == []
      (questions_with_answers - notices_questions).should == []
    end

    it "should return in right order" do
      @tommy.asked_questions.sort_by(&:updated_at).should == [@q1, @q2]
      @tommy.list_questions_notices.should == [@q2, @q1]
    end
  end
end
