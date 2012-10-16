require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = User.where(:name => "tom").first

    @department = Department.create :name => "xinxi"
    @major = Major.create :name => "pc"
    @course_a = Course.create :name => "math"
    @course_b = Course.create :name => "english"
    @major.courses = [@course_a, @course_b]
    @major.save

    @department.majors << @majors
    @department.save
  end

  describe "#set_courses_with_major" do
    it "should copy all major courses to user" do
      @user.courses = []
      @user.save
      @user.reload
      @user.courses.should == []

      post :set_courses_with_major, :id => @user.id, :major_id => @major.id
      @user.reload

      @user.courses.include?(@course_a).should be_true
      @user.courses.include?(@course_b).should be_true
    end

    it "should set user department by the way" do
      post :set_courses_with_major, :id => @user.id, :major_id => @major.id
      @user.reload
      @user.department = @department
    end
  end
end
