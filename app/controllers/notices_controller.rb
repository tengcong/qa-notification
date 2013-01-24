class NoticesController < ApplicationController
  def index
    @notices = current_user.notices.sorted
    current_user.clear_notices
  end
end
