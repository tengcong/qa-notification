require "#{Rails.root}/lib/init_helper.rb"
class Administration::HomeController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @to_be_teachers = User.where(:role => "to_be_teacher")
    @departments = Department.all
    @questions = Question.all
  end

  def initialize_datas
    ::InitHelper.run
    render :text => 'ok'
  end
end
