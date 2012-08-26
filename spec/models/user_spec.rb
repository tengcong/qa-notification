require 'spec_helper'

describe User do
  describe "#lastest_question_of_my_courses" do
    before(:each) do
      @tommy = User.new :name => 'tommy', :role => "student"
      generate_courses_with_questions_for @tommy
    end

    it "should return all courses questions" do
      questions = @tommy.lastest_question_of_my_courses
      questions.size.should == 3

      (questions.map(&:title) - %w-mq1 mq2 eq1-).should == []

    end
    it "should return right order of questions" do
      origin_questions = []
      @tommy.courses.map(&:questions).flatten.each do |q|
        q.save
        sleep 1.0
        origin_questions << q
      end

      question_1 = origin_questions[0]
      question_2 = origin_questions[1]

      # 1. edit question_2 then it should be before question_1
      # 2. query all question with right order
      sleep 1.0
      answers_generator question_2
      question_2.save

      # 1
      questions = @tommy.lastest_question_of_my_courses

      questions.index(question_2).should be < questions.index(question_1)

      # 2
      questions.should == questions.sort_by(&:updated_at).reverse
    end
  end
end
