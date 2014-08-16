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

ActiveRecord::Schema.define(version: 20140816014601) do

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

  create_table "players", force: true do |t|
    t.string   "first_name",                   null: false
    t.string   "last_name",                    null: false
    t.string   "position",                     null: false
    t.string   "team",          default: "FA", null: false
    t.date     "birthdate"
    t.string   "college"
    t.string   "height"
    t.integer  "weight"
    t.integer  "years_pro"
    t.integer  "profile_id"
    t.string   "gsis_id"
    t.integer  "rank"
    t.integer  "pass_yards",    default: 0
    t.integer  "pass_tds",      default: 0
    t.integer  "pass_ints",     default: 0
    t.integer  "rush_att",      default: 0
    t.integer  "rush_yards",    default: 0
    t.integer  "rush_tds",      default: 0
    t.integer  "receptions",    default: 0
    t.integer  "rec_yards",     default: 0
    t.integer  "rec_tds",       default: 0
    t.integer  "fumbles",       default: 0
    t.integer  "pass_2_pt",     default: 0
    t.integer  "rush_2_pt",     default: 0
    t.integer  "rec_2_pt",      default: 0
    t.integer  "fg_made_yards", default: 0
    t.integer  "fg_miss_yards", default: 0
    t.integer  "made_pat",      default: 0
    t.integer  "miss_pat",      default: 0
    t.integer  "made_0_19",     default: 0
    t.integer  "miss_0_19",     default: 0
    t.integer  "made_20_29",    default: 0
    t.integer  "miss_20_29",    default: 0
    t.integer  "made_30_39",    default: 0
    t.integer  "miss_30_39",    default: 0
    t.integer  "made_40_49",    default: 0
    t.integer  "miss_40_49",    default: 0
    t.integer  "made_50_plus",  default: 0
    t.integer  "miss_50_plus",  default: 0
    t.integer  "sacks",         default: 0
    t.integer  "interceptions", default: 0
    t.integer  "fum_rec",       default: 0
    t.integer  "safeties",      default: 0
    t.integer  "def_tds",       default: 0
    t.integer  "return_tds",    default: 0
    t.integer  "pts_allowed",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["last_name", "first_name"], name: "index_players_on_last_name_and_first_name", using: :btree
  add_index "players", ["position"], name: "index_players_on_position", using: :btree
  add_index "players", ["team"], name: "index_players_on_team", using: :btree

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
    t.integer  "owner_id"
    t.integer  "league_id",                     null: false
    t.integer  "draft_slot",                    null: false
    t.string   "color",      default: "007DBD", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["draft_slot", "league_id"], name: "index_teams_on_draft_slot_and_league_id", using: :btree
  add_index "teams", ["league_id"], name: "index_teams_on_league_id", using: :btree
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
