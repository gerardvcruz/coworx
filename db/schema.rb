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

ActiveRecord::Schema.define(version: 20160423201357) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.json     "info"
    t.json     "settings"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.integer  "user_id"
    t.decimal  "amount"
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "info"
    t.datetime "due_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.integer  "user_id"
    t.decimal  "amount"
    t.datetime "paid_at"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.integer  "user_id"
    t.integer  "pricing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.string   "name"
    t.decimal  "price"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pricings", ["slug"], name: "index_pricings_on_slug", unique: true, using: :btree

  create_table "reservations", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.integer  "room_id"
    t.datetime "start"
    t.datetime "end"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "space_id"
    t.json     "info"
    t.json     "settings"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rooms", ["slug"], name: "index_rooms_on_slug", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "space_id"
    t.integer  "client_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "active",     default: true
  end

  create_table "space_users", force: :cascade do |t|
    t.integer  "space_id"
    t.integer  "user_id"
    t.json     "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spaces", force: :cascade do |t|
    t.integer  "client_id"
    t.json     "settings"
    t.json     "info"
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "capacity",   default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.integer  "client_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
