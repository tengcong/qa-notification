class SearchController < ApplicationController
  def index
    query_string = params[:q]
    @questions = Question.search_questions(query_string).to_a
  end
end
