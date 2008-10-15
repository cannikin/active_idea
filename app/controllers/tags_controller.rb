class TagsController < ApplicationController
  def index
  end

  def show
    @ideas = Idea.find_tagged_with(params[:tag], :order => 'created_at desc')
    @page_title = " - Ideas Tagged with &quot;#{params[:tag]}&quot;"
  end

end
