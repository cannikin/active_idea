class AddUserIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :ideas, :user_id, :integer
  end

  def self.down
    remove_column :ideas, :user_id
  end
end
