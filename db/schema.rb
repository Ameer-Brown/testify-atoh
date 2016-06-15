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

ActiveRecord::Schema.define(version: 20160615111352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text     "comment"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "testimony_id"
    t.integer  "user_id"
  end

  add_index "comments", ["testimony_id"], name: "index_comments_on_testimony_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "testimonies", force: :cascade do |t|
    t.string   "title"
    t.text     "verse"
    t.string   "picture"
    t.string   "video"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.text     "message"
  end

  add_index "testimonies", ["user_id"], name: "index_testimonies_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "avatar"
    t.string   "username"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "comments", "testimonies"
  add_foreign_key "comments", "users"
  add_foreign_key "testimonies", "users"
end
