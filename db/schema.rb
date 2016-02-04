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

ActiveRecord::Schema.define(version: 20160202103914) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.string   "kind"
    t.text     "message"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "reports", ["reportable_type", "reportable_id"], name: "index_reports_on_reportable_type_and_reportable_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "settings_suits", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "notifications", default: true
    t.boolean  "use_location",  default: true
    t.boolean  "public",        default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "settings_suits", ["user_id"], name: "index_settings_suits_on_user_id", using: :btree

  create_table "stories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.boolean  "public",      default: false
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "stories", ["user_id"], name: "index_stories_on_user_id", using: :btree

  create_table "stories_story_points", id: false, force: :cascade do |t|
    t.integer "story_id"
    t.integer "story_point_id"
  end

  add_index "stories_story_points", ["story_id"], name: "index_stories_story_points_on_story_id", using: :btree
  add_index "stories_story_points", ["story_point_id"], name: "index_stories_story_points_on_story_point_id", using: :btree

  create_table "story_points", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file"
    t.text     "text"
    t.string   "caption"
    t.string   "location"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "variation"
    t.boolean  "public",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "story_points", ["user_id"], name: "index_story_points_on_user_id", using: :btree

  create_table "story_points_tags", id: false, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "story_point_id"
  end

  add_index "story_points_tags", ["story_point_id"], name: "index_story_points_tags_on_story_point_id", using: :btree
  add_index "story_points_tags", ["tag_id"], name: "index_story_points_tags_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "home"
    t.text     "about"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "avatar"
    t.string   "email"
    t.string   "personal_url"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "settings_suits", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "story_points", "users"
end
