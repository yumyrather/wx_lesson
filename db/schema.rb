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

ActiveRecord::Schema.define(version: 20140929053659) do

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

  create_table "sys_app_users", id: false, force: true do |t|
    t.string  "USER_ID",    limit: 100
    t.string  "USERNAME"
    t.string  "PASSWORD"
    t.string  "NAME"
    t.string  "RIGHTS"
    t.string  "ROLE_ID",    limit: 100
    t.string  "LAST_LOGIN"
    t.string  "IP",         limit: 100
    t.string  "STATUS",     limit: 32
    t.string  "BZ"
    t.string  "PHONE",      limit: 100
    t.string  "SFID",       limit: 100
    t.string  "START_TIME", limit: 100
    t.string  "END_TIME",   limit: 100
    t.integer "YEARS",                  default: 0
    t.string  "WEIXINID"
    t.string  "TOROLE_ID"
  end

  create_table "wx_articles", force: true do |t|
    t.string   "title"
    t.string   "cover"
    t.string   "breif"
    t.text     "content",     limit: 2147483647
    t.boolean  "hidden",                         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public_flag",                    default: true
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
  end

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
