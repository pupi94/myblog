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

ActiveRecord::Schema.define(version: 20170523135813) do

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title",        limit: 64,                   null: false
    t.string   "source_type",  limit: 16,                   null: false
    t.string   "source",       limit: 64
    t.string   "source_url",   limit: 128
    t.integer  "category_id",                               null: false
    t.string   "tags",         limit: 64,                   null: false
    t.string   "summary"
    t.integer  "author_id",                                 null: false
    t.string   "author_name",  limit: 32,                   null: false
    t.integer  "pv",                         default: 0,    null: false
    t.string   "status",       limit: 16,                   null: false
    t.boolean  "enabled",                    default: true, null: false
    t.datetime "pubdate"
    t.text     "content",      limit: 65535
    t.text     "content_html", limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["author_id"], name: "fk_rails_e74ce85cbc", using: :btree
    t.index ["category_id"], name: "fk_rails_af09d53ead", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       limit: 32,                null: false
    t.integer  "seq",        limit: 2,                 null: false
    t.boolean  "enabled",               default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "username",   limit: 32,                null: false
    t.string   "password",   limit: 64,                null: false
    t.string   "nickname",   limit: 32,                null: false
    t.boolean  "enabled",               default: true, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users", column: "author_id"
end
