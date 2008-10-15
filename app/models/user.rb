class User < ActiveRecord::Base
  
  has_many :ideas
  has_many :comments, :order => 'created_at desc'
  
  def self.find_by_name_or_create(name)
    user = find_by_name(name)
    if user.nil?
      user = User.new({:name => name})
      user.save
    end
    user
  end
  
end
