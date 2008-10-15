# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 7) do

  create_table "comments", :force => true do |t|
    t.text     "body",       :default => "NULL"
    t.integer  "user_id",    :default => 0
    t.integer  "idea_id",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", :force => true do |t|
    t.string   "title",       :default => "NULL"
    t.text     "body",        :default => "NULL"
    t.integer  "votes",       :default => 1
    t.integer  "category_id", :default => 0
    t.string   "author",      :default => "NULL"
    t.boolean  "in_action",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "url"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :default => 0
    t.integer  "taggable_id",   :default => 0
    t.string   "taggable_type", :default => "NULL"
    t.datetime "created_at"
  end

  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string "name", :default => "NULL"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :default => "NULL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id",    :default => 0
    t.integer  "idea_id",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
