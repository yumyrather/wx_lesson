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

ActiveRecord::Schema.define(version: 20141130134129) do

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "kindeditor_assets", force: true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.integer  "owner_id"
    t.string   "asset_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wx_articles", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.string   "breif"
    t.text     "content",      limit: 2147483647
    t.boolean  "hidden",                          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_flag",                     default: true
    t.integer  "like_count",                      default: 0,     null: false
    t.integer  "view_count",                      default: 0,     null: false
    t.integer  "share_count",                     default: 0,     null: false
    t.boolean  "is_linked",                       default: false
    t.string   "linked_url"
    t.date     "published_at"
  end

  create_table "wx_chapters", force: true do |t|
    t.integer  "wx_lesson_id"
    t.string   "title"
    t.integer  "no"
    t.string   "cover"
    t.text     "content",        limit: 2147483647
    t.integer  "reader_counter",                    default: 0
    t.boolean  "public_flag",                       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_keyword_items", force: true do |t|
    t.integer  "wx_keyword_id"
    t.integer  "wx_article_id"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_keywords", force: true do |t|
    t.string   "keyword"
    t.string   "keyword_type"
    t.boolean  "hidden",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_lesson_user_records", force: true do |t|
    t.integer  "wx_lesson_id"
    t.integer  "wx_user_id"
    t.datetime "last_signin"
    t.integer  "now_chatpter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_lessons", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.text     "content",           limit: 2147483647
    t.integer  "wx_chapters_count"
    t.boolean  "public_flag",                          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "frequency",                            default: "每周"
  end

  create_table "wx_lesssons_sign_logs", force: true do |t|
    t.integer  "wx_lesson_id"
    t.integer  "wx_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_menus", force: true do |t|
    t.integer  "public_account_id"
    t.integer  "parent_id"
    t.string   "name"
    t.string   "key"
    t.string   "url"
    t.boolean  "is_show",           default: true
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wx_menus", ["key"], name: "index_wx_menus_on_key", using: :btree
  add_index "wx_menus", ["parent_id"], name: "index_wx_menus_on_parent_id", using: :btree
  add_index "wx_menus", ["public_account_id"], name: "index_wx_menus_on_public_account_id", using: :btree

  create_table "wx_roles", force: true do |t|
    t.string   "name"
    t.boolean  "admin_flag", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wx_users", force: true do |t|
    t.string   "open_id"
    t.string   "username"
    t.string   "name"
    t.string   "password"
    t.string   "rights"
    t.integer  "wx_role_id"
    t.datetime "last_login"
    t.string   "ip"
    t.string   "status"
    t.string   "remark"
    t.string   "phone"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "year",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
