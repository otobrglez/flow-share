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

ActiveRecord::Schema.define(version: 20140124151716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "attachments", force: true do |t|
    t.string   "file"
    t.string   "name"
    t.string   "content_type"
    t.integer  "file_size",       default: 0
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "single",          default: 0
    t.string   "color"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "flow_accesses", force: true do |t|
    t.integer  "flow_id",                        null: false
    t.integer  "user_id",                        null: false
    t.string   "role",       default: "creator", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "flow_accesses", ["flow_id"], name: "index_flow_accesses_on_flow_id", using: :btree
  add_index "flow_accesses", ["user_id"], name: "index_flow_accesses_on_user_id", using: :btree

  create_table "flows", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id",                        null: false
    t.string   "token",      limit: 10
    t.integer  "public",                default: 0
    t.integer  "open",                  default: 0
  end

  add_index "flows", ["creator_id"], name: "index_flows_on_creator_id", using: :btree
  add_index "flows", ["token"], name: "index_flows_on_token", unique: true, using: :btree

  create_table "steps", force: true do |t|
    t.text     "name"
    t.integer  "flow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "row_order"
    t.integer  "assignee_id"
    t.integer  "achiever_id"
  end

  add_index "steps", ["achiever_id"], name: "index_steps_on_achiever_id", using: :btree
  add_index "steps", ["assignee_id"], name: "index_steps_on_assignee_id", using: :btree
  add_index "steps", ["flow_id"], name: "index_steps_on_flow_id", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
    t.string   "username",                            null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
