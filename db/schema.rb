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

ActiveRecord::Schema.define(version: 20140725161624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "leagues", force: true do |t|
    t.string   "name",                         null: false
    t.string   "tagline"
    t.integer  "manager_id",                   null: false
    t.integer  "number_of_teams", default: 10, null: false
    t.string   "password_digest",              null: false
    t.string   "activation_key",               null: false
    t.hstore   "positions",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leagues", ["manager_id"], name: "index_leagues_on_manager_id", using: :btree
  add_index "leagues", ["name"], name: "index_leagues_on_name", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.string   "device"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", unique: true, using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name",                          null: false
    t.integer  "owner_id",                      null: false
    t.integer  "league_id",                     null: false
    t.integer  "draft_slot",                    null: false
    t.string   "color",      default: "007DBD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["draft_slot", "league_id"], name: "index_teams_on_draft_slot_and_league_id", unique: true, using: :btree
  add_index "teams", ["owner_id"], name: "index_teams_on_owner_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
