class NoticesController < ApplicationController
  def index
    @notices = current_user.notices
    current_user.clear_notices
  end
end
