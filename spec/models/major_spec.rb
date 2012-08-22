require 'spec_helper'

describe Major do

  def major_with_courses_generator
    major = Major.new :name => "IT"
    courses_with_questions_generator major
    major
  end

  def courses_with_questions_generator major
    math = Course.new :name => "math"
    english = Course.new :name => "english"

    questions_generator math, english
    major.courses = [math, english]
  end

  def questions_generator *courses
    mq1 = Question.new :title => "mq1", :content => "cccc"
    mq2 = Question.new :title => "mq2", :content => "bbb"
    eq1 = Question.new :title => "eq1", :content => "xxx"

    courses.select{|course| course.name == "math"}.first.questions = [mq1, mq2]
    courses.select{|course| course.name == "english"}.first.questions = [eq1]
  end

  before(:each) do
    @major = major_with_courses_generator
  end
  describe "#find_all_related_questions" do
    it "should query all courses questions of this marjor" do
      questions = @major.find_all_related_questions

      questions.size.should == 3
      ["mq1", "mq2", "eq1"].should be_any{|title| questions.map(&:title).include? title}
    end
  end
end
