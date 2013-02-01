class ApplicationController < ActionController::Base
  include ApplicationHelper

  def admin_signed_in?
    current_user.is_admin?
  end

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to new_user_session_path
    end
  end

end
