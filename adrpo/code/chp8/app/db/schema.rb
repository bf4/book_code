#---
# Excerpted from "Ruby Performance Optimization",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/adrpo for more book information.
#---
# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140724142101) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "minions", force: true do |t|
    t.integer "thing_id"
    t.string  "mcol0"
    t.string  "mcol1"
    t.string  "mcol2"
    t.string  "mcol3"
    t.string  "mcol4"
    t.string  "mcol5"
    t.string  "mcol6"
    t.string  "mcol7"
    t.string  "mcol8"
    t.string  "mcol9"
  end

  create_table "things", force: true do |t|
    t.string "col0"
    t.string "col1"
    t.string "col2"
    t.string "col3"
    t.string "col4"
    t.string "col5"
    t.string "col6"
    t.string "col7"
    t.string "col8"
    t.string "col9"
  end

end
