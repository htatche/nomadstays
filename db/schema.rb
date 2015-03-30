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

ActiveRecord::Schema.define(version: 20150330211308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "accesstoken"
    t.string   "refreshtoken"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "nickname"
    t.string   "image"
    t.string   "phone"
    t.string   "urls"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "stays", force: :cascade do |t|
    t.string   "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city",                 null: false
    t.string   "state",                null: false
    t.string   "country",              null: false
    t.string   "full_street_address",  null: false
    t.string   "airport_transfer"
    t.boolean  "laundry"
    t.boolean  "cleaning"
    t.boolean  "data_sim_card"
    t.boolean  "wifi",                 null: false
    t.string   "wifi_speed"
    t.boolean  "mobile_data"
    t.string   "mobile_data_speed"
    t.string   "accomodation_type"
    t.boolean  "terrace"
    t.boolean  "router_access"
    t.boolean  "desk"
    t.text     "description"
    t.boolean  "not_available"
    t.text     "not_available_reason"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               default: "", null: false
    t.string   "last_name",              default: ""
    t.string   "first_name"
    t.string   "photo"
    t.date     "birthdate"
    t.string   "origin_country"
    t.string   "current_city"
    t.string   "current_country"
    t.string   "description"
    t.string   "activity"
    t.integer  "thrusted"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
end
