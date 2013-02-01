class Administration::HomeController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @to_be_teachers = User.where(:role => "to_be_teacher")
  end
end
