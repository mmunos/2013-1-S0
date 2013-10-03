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

ActiveRecord::Schema.define(version: 20131003195411) do

  create_table "movies", force: true do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "director"
    t.string   "genre"
    t.integer  "duration"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies_users", id: false, force: true do |t|
    t.integer "movie_id"
    t.integer "user_id"
  end

  add_index "movies_users", ["movie_id", "user_id"], name: "index_movies_users_on_movie_id_and_user_id", unique: true

  create_table "serials", force: true do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "genre"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "serials_users", id: false, force: true do |t|
    t.integer "serial_id"
    t.integer "user_id"
  end

  add_index "serials_users", ["serial_id", "user_id"], name: "index_serials_users_on_serial_id_and_user_id", unique: true

  create_table "show_users", force: true do |t|
    t.integer "show_id"
    t.integer "user_id"
    t.text    "type"
  end

  create_table "shows", force: true do |t|
    t.string   "name"
    t.datetime "date"
    t.string   "genre"
    t.text     "description"
    t.string   "director"
    t.integer  "duration"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "role"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
