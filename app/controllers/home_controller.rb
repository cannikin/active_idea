class HomeController < ApplicationController
  
  def index
    @recent_ideas = Idea.find_recent(8)
    @highest_rated_ideas = Idea.find_highest_rated(5)
    @total_ideas = Idea.count
    @idea = Idea.new(:user => get_user_from_cookie)
    @idea.title = ''
    @idea.body = ''
    @tags = Idea.tag_counts
    
    @page_title = ' - what\'s yours?'
  end
  
end