class AddUrlColumnToIdeas < ActiveRecord::Migration
  def self.up
    add_column :ideas, :url, :string
    
    # update all existing ideas and add a URL
    ideas = Idea.find(:all)
    ideas.each do |idea|
      idea.save
    end
    
  end

  def self.down
    remove_column :ideas, :url
  end
end
