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

ActiveRecord::Schema.define(version: 20150417153907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string   "first_name",    null: false
    t.string   "last_name",     null: false
    t.date     "date_of_birth", null: false
    t.string   "gender",        null: false
    t.string   "team"
    t.string   "id_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attempts", force: :cascade do |t|
    t.integer  "athlete_id", null: false
    t.integer  "route_id",   null: false
    t.float    "score",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bibs", force: :cascade do |t|
    t.string  "number"
    t.integer "athlete_id",     null: false
    t.integer "competition_id", null: false
  end

  add_index "bibs", ["athlete_id", "competition_id"], name: "index_bibs_on_athlete_id_and_competition_id", unique: true, using: :btree
  add_index "bibs", ["number", "competition_id"], name: "index_bibs_on_number_and_competition_id", unique: true, using: :btree

  create_table "competitions", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "gender"
    t.string   "division"
    t.integer  "user_id",    null: false
    t.date     "start_date", null: false
    t.date     "end_date"
    t.string   "gym"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: :cascade do |t|
    t.string  "name",           null: false
    t.integer "number",         null: false
    t.integer "competition_id", null: false
  end

  add_index "rounds", ["competition_id", "name"], name: "index_rounds_on_competition_id_and_name", unique: true, using: :btree
  add_index "rounds", ["competition_id", "number"], name: "index_rounds_on_competition_id_and_number", unique: true, using: :btree

  create_table "routes", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "round_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "max_score",  null: false
  end

  add_index "routes", ["round_id", "name"], name: "index_routes_on_round_id_and_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
