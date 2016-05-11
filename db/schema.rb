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

ActiveRecord::Schema.define(version: 20160511185309) do

  create_table "cards", force: :cascade do |t|
    t.string  "image_url"
    t.string  "multiverse_id"
    t.boolean "is_planeswalker"
    t.boolean "is_land"
    t.boolean "is_enchantment"
    t.boolean "is_artifact"
    t.boolean "is_sorcery"
    t.boolean "is_instant"
    t.boolean "is_creature"
    t.boolean "is_colorless"
    t.boolean "is_blue"
    t.boolean "is_white"
    t.boolean "is_red"
    t.boolean "is_black"
    t.boolean "is_green"
    t.string  "cmc"
    t.string  "name"
  end

  create_table "drafts", force: :cascade do |t|
    t.string "user_id"
    t.string "set3"
    t.string "set2"
    t.string "set1"
    t.string "color3"
    t.string "color2"
    t.string "color1"
  end

  create_table "selections", force: :cascade do |t|
    t.string  "card_id"
    t.string  "draft_id"
    t.boolean "is_sideboard"
  end

  create_table "sets", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
