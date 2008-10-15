class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :title
      t.text :body
      t.integer :votes, :default => 1
      t.integer :category_id
      t.string :author
      t.boolean :in_action, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
