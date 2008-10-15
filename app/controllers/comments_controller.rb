class CommentsController < ApplicationController
  def index
  end

  def list
  end

  def new
    @comment = Comment.new
  end

  def create
    # get this user out of the database, or create it if it's new
    user = User.find_by_name_or_create(params[:user_name])
    set_user_cookie(user)
    
    @comment = Comment.new({ :user => user, :body => params[:comment][:body], :idea_id => params[:idea_id] })
    if @comment.save
      create_rss
      render :partial => 'comment', :locals => { :comment => @comment }
    end
  end
  
  private
  def create_rss
    comments = Comment.find(:all, :limit => 10, :order => 'created_at desc')
    
    require 'rss/maker'
    
    version = "2.0" # ["0.9", "1.0", "2.0"]
    destination = RAILS_ROOT + "/public/comments_rss.xml" # local file to write

    content = RSS::Maker.make(version) do |m|
      m.channel.title = "Active Ideas Comment RSS Feed"
      m.channel.link = "http://ideas.active.com"
      m.channel.description = "Comments on awesome ideas for Active"
      m.channel.language = 'en-us'
      m.channel.generator = 'Ruby\'s RSS::Maker'
      m.channel.pubDate = Time.now
      m.items.do_sort = true # sort items by date

      comments.each do |comment|
        i = m.items.new_item
        i.title = comment.idea.title
        i.link = idea_url(comment.idea.id, :anchor => comment.id)
        i.pubDate = Time.parse(comment.created_at.to_s)
        i.description = comment.body
        i.author = comment.user.nil? ? 'Anonymous' : comment.user.name
      end
    end

    File.open(destination,"w") do |f|
      f.write(content)
    end
    
  end

end
