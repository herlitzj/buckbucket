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

ActiveRecord::Schema.define(version: 20160117174150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "claimed_markers", force: :cascade do |t|
    t.integer  "marker_id",                  null: false
    t.integer  "owner_id",                   null: false
    t.integer  "claimer_id",                 null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "paid",       default: false, null: false
  end

  create_table "markers", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.float    "lat"
    t.float    "lon"
    t.text     "description"
    t.string   "title"
    t.integer  "user_id"
    t.decimal  "price",       precision: 5, scale: 2
  end

  add_index "markers", ["user_id"], name: "index_markers_on_user_id", using: :btree

  create_table "tokens", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.string   "uid",                 null: false
    t.string   "provider",            null: false
    t.string   "location"
    t.string   "email"
    t.string   "url"
    t.string   "nickname"
    t.string   "phone"
    t.string   "venmo_token"
    t.string   "venmo_refresh_token"
  end

  add_index "users", ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

end
