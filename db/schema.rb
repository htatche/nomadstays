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

ActiveRecord::Schema.define(version: 20150406151054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.integer  "stay_id"
    t.integer  "nrooms"
    t.integer  "floor"
    t.boolean  "lift"
    t.boolean  "security"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "apartments", ["stay_id"], name: "index_apartments_on_stay_id", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "stay_id"
    t.date     "date_from",                             null: false
    t.date     "date_to",                               null: false
    t.integer  "stay_length_in_months",                 null: false
    t.boolean  "paid",                  default: false, null: false
    t.boolean  "accepted"
    t.boolean  "service_pickup"
    t.boolean  "service_laundry"
    t.boolean  "service_cleaning"
    t.boolean  "service_sim_card"
    t.text     "special_request"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "bookings", ["stay_id"], name: "index_bookings_on_stay_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "houses", force: :cascade do |t|
    t.integer  "stay_id"
    t.boolean  "garden"
    t.boolean  "terrace"
    t.boolean  "alarm"
    t.boolean  "nomad_house"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "houses", ["stay_id"], name: "index_houses_on_stay_id", using: :btree

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

  create_table "rooms", force: :cascade do |t|
    t.integer  "stay_id"
    t.string   "title"
    t.integer  "sqm"
    t.boolean  "desk"
    t.boolean  "kitchen_access"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "rooms", ["stay_id"], name: "index_rooms_on_stay_id", using: :btree

  create_table "stays", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                  null: false
    t.text     "description"
    t.string   "accomodation_type"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street_address",         null: false
    t.string   "city",                   null: false
    t.string   "state",                  null: false
    t.string   "country",                null: false
    t.string   "full_address",           null: false
    t.boolean  "wifi",                   null: false
    t.string   "wifi_speed"
    t.boolean  "mobile_data"
    t.string   "mobile_data_speed"
    t.boolean  "terrace"
    t.boolean  "router_access"
    t.boolean  "desk"
    t.boolean  "service_pickup"
    t.integer  "service_pickup_price"
    t.boolean  "service_laundry"
    t.integer  "service_laundry_price"
    t.boolean  "service_cleaning"
    t.integer  "service_cleaning_price"
    t.boolean  "service_sim_card"
    t.integer  "service_sim_card_price"
    t.boolean  "available"
    t.integer  "monthly_price"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stays", ["user_id"], name: "index_stays_on_user_id", using: :btree

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
    t.integer  "trusted"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
end
