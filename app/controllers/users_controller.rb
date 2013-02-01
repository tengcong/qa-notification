class UsersController < ApplicationController

  before_filter :find_user

  def show
  end

  def set_courses_with_major
    @user.set_self_info params[:major_id]
    render :nothing => true
  end

  def set_role
    role = params[:role]
    @user.set_role role
    render :text => "role info to be confirmed ..."
  end

  def show_to_be_confirmed_teachers
    @to_be_teachers = User.where(:role => "to_be_teacher")
  end

  def set_teacher
    @user.confirm_teacher
    render :text => "set successfully"
  end

  def set_student
    @user.confirm_student
    render :text => "set successfully"
  end

  private
  def find_user
    @user = User.find params[:id]
  end
end
