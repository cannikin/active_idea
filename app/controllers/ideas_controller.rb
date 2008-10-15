class IdeasController < ApplicationController
  
  def index
    @ideas = Idea.find(:all, :order => 'created_at desc')
    @page_title = ' - All Ideas'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ideas }
      format.json { render :text => @ideas.to_json }
    end
  end
  
  def vote
    @idea = Idea.find(params[:id])
    @idea.votes += 1
    @idea.save
    
    render :text => @idea.votes
  end
  
  def count
    render :text => Idea.count
  end

  def show
    if params[:url]
      @idea = Idea.find_by_url(params[:url])
    else
      @idea = Idea.find(params[:id])
    end
    @comment = Comment.new(:user => get_user_from_cookie)
    @page_title = " - #{@idea.title}"

    respond_to do |format|
      format.html
      format.xml  { render :xml => @idea }
      format.json { render :text => @idea.to_json }
    end
  end

  def new
    @idea = Idea.new
    @page_title = " - Add Your Idea"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @idea }
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def create
    unless params[:user_name].blank?
      user = User.find_by_name_or_create(params[:user_name])
      set_user_cookie(user)
    else
      user = nil
    end
    
    @idea = Idea.new({ :title => params[:idea][:title], :body => params[:idea][:body], :user => user })
    
    # create an array of the tags, removing any whitespace
    tags = params[:tags].split(',')
    @idea.tag_list.add(tags)

    if @idea.save
      create_rss      # update the RSS file      
      if request.xhr?
        render :layout => false
      else
        redirect_to links_url
      end
    end
    
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update_attributes(params[:idea])

      new_tags = params[:tags].split(',')
      @idea.tag_list.remove(@idea.tag_list)   # clear the list of tags
      @idea.tag_list.add(new_tags)            # add the ones created by edit
      @idea.save                              # save them
      
      flash[:notice] = 'Idea was successfully updated.'
      redirect_to(@idea)
    else
      render :action => 'edit'
    end
    
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy

    respond_to do |format|
      format.html { redirect_to(ideas_url) }
      format.xml  { head :ok }
    end
  end
  
  def in_action
    @ideas = Idea.find(:all, :conditions => 'in_action = 1')
    @page_title = " - In Action"
    render :action => 'index'
  end
  
  private
  def create_rss
    @ideas = Idea.find(:all, :limit => 10, :order => 'created_at desc')
    
    require 'rss/maker'
    
    version = "2.0" # ["0.9", "1.0", "2.0"]
    destination = RAILS_ROOT + "/public/ideas_rss.xml" # local file to write

    content = RSS::Maker.make(version) do |m|
      m.channel.title = "Active Ideas RSS Feed"
      m.channel.link = "http://ideas.active.com"
      m.channel.description = "Awesome ideas for Active"
      m.channel.language = 'en-us'
      m.channel.generator = 'Ruby\'s RSS::Maker'
      m.channel.pubDate = Time.now
      m.items.do_sort = true # sort items by date

      @ideas.each do |idea|
        i = m.items.new_item
        i.title = idea.title
        i.link = idea_url(idea.id)
        i.pubDate = Time.parse(idea.created_at.to_s)
        i.description = idea.body
        i.author = idea.user.nil? ? 'Anonymous' : idea.user.name
      end
    end

    File.open(destination,"w") do |f|
      f.write(content)
    end
  end
end
