require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = User.where(:name => "tom").first
    unless @user
      @user = User.create(:name => "tom", :email => "xx@1.com")
    end

    @department = Department.create :name => "xinxi"
    @major = Major.create :name => "pc"
    @course_a = Course.create :name => "math"
    @course_b = Course.create :name => "english"
    @major.courses = [@course_a, @course_b]
    @major.save

    @department.majors << @majors
    @department.save
  end

  describe "#set_role" do
    it "should will mark user to teacher" do
      @user.role = "student"
      @user.save

      put :set_role, :role => "teacher", :id => @user.id
      @user.reload
      @user.role.should == "to_be_teacher"
    end
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
