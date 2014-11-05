#---
# Excerpted from "Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/rr2 for more book information.
#---
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101202135612) do

  create_table "inboxes", :force => true do |t|
    t.integer "user_id"
    t.string  "access_key"
  end

  create_table "messages", :force => true do |t|
    t.integer  "inbox_id"
    t.integer  "sender_id"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
  end

  create_table "users", :force => true do |t|
    t.string "name"
    t.string "password"
  end

end
