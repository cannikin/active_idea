class Idea < ActiveRecord::Base
  
  acts_as_taggable
  
  has_many :comments, :order => 'created_at asc'
  belongs_to :user
  belongs_to :category
  
  def self.find_recent(count=5)
    Idea.find(:all, :order => 'created_at desc', :limit => count)
  end
  
  def self.find_highest_rated(count=5)
    Idea.find(:all, :order => 'votes desc', :limit => count)
  end
  
  def before_save
    # create a URL based on the title
    self.url = self.title.downcase.gsub(/\W/,'_').gsub(/_+/,'_').gsub(/_$/,'')
  end
  
end
