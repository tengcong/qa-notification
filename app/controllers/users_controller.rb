class UsersController < ApplicationController

  def set_courses_with_major
    user = User.find params[:id]
    user.set_self_info params[:major_id]
    render :nothing => true
  end

end
