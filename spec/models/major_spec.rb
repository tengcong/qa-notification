require 'spec_helper'

describe Major do

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
