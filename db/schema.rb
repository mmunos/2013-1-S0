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

ActiveRecord::Schema.define(version: 20131028003052) do

  create_table "episode_taggings", force: true do |t|
    t.integer  "episode_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episode_taggings", ["episode_id"], name: "index_episode_taggings_on_episode_id"

  create_table "episode_users", force: true do |t|
    t.integer  "episode_id"
    t.integer  "watched_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "episodes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "date"
    t.integer  "number"
    t.string   "write"
    t.string   "director"
    t.integer  "duration"
    t.integer  "season_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "episodes", ["season_id"], name: "index_episodes_on_season_id"

  create_table "movie_user", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_users", force: true do |t|
    t.integer  "show_id"
    t.integer  "watched_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.float    "rating"
    t.text     "content"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "seasons", force: true do |t|
    t.text     "description"
    t.date     "date"
    t.integer  "number"
    t.integer  "serial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["serial_id"], name: "index_seasons_on_serial_id"

  create_table "show_users", force: true do |t|
    t.integer "show_id"
    t.integer "user_id"
    t.text    "type"
  end

  create_table "show_watchlists", force: true do |t|
    t.integer  "show_id"
    t.integer  "watchlist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_episode_taggings", force: true do |t|
    t.integer  "user_id"
    t.integer  "episode_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_episode_taggings", ["episode_id"], name: "index_user_episode_taggings_on_episode_id"
  add_index "user_episode_taggings", ["user_id"], name: "index_user_episode_taggings_on_user_id"

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

  create_table "watcheds", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watcheds", ["user_id"], name: "index_watcheds_on_user_id"

  create_table "watchlists", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "watchlists", ["user_id"], name: "index_watchlists_on_user_id"

end
