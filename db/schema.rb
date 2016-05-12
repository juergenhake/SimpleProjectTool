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

ActiveRecord::Schema.define(version: 20160512134352) do

  create_table "attachments", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "upload_at",         default: '2016-05-11 11:40:04', null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "customer_id"
    t.integer  "task_id"
    t.integer  "project_id"
    t.integer  "component_id"
    t.integer  "user_id"
  end

  add_index "attachments", ["component_id"], name: "index_attachments_on_component_id"
  add_index "attachments", ["customer_id"], name: "index_attachments_on_customer_id"
  add_index "attachments", ["project_id"], name: "index_attachments_on_project_id"
  add_index "attachments", ["task_id"], name: "index_attachments_on_task_id"
  add_index "attachments", ["user_id"], name: "index_attachments_on_user_id"

  create_table "components", force: :cascade do |t|
    t.string   "component_id_sap"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "customer_id"
    t.integer  "projects_id"
  end

  add_index "components", ["customer_id"], name: "index_components_on_customer_id"
  add_index "components", ["projects_id"], name: "index_components_on_projects_id"

  create_table "components_customers", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "component_id"
  end

  add_index "components_customers", ["component_id"], name: "index_components_customers_on_component_id"
  add_index "components_customers", ["customer_id"], name: "index_components_customers_on_customer_id"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "customer_id_sap"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "component_id"
    t.integer  "projects_id"
  end

  add_index "customers", ["component_id"], name: "index_customers_on_component_id"
  add_index "customers", ["projects_id"], name: "index_customers_on_projects_id"

  create_table "histories", force: :cascade do |t|
    t.string   "message"
    t.boolean  "systemflag",   default: false
    t.integer  "customer_id"
    t.integer  "task_id"
    t.integer  "project_id"
    t.integer  "component_id"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "histories", ["component_id"], name: "index_histories_on_component_id"
  add_index "histories", ["customer_id"], name: "index_histories_on_customer_id"
  add_index "histories", ["project_id"], name: "index_histories_on_project_id"
  add_index "histories", ["task_id"], name: "index_histories_on_task_id"
  add_index "histories", ["user_id"], name: "index_histories_on_user_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "customer_id"
    t.integer  "task_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "type"
    t.datetime "started_at",       default: '2016-05-11 11:40:04'
    t.datetime "finished_at"
    t.boolean  "finished_flag"
    t.string   "reklamation_lief"
    t.string   "lief_nr"
    t.string   "finished_text"
    t.integer  "component_id"
    t.integer  "user_id"
    t.integer  "attachments_id"
  end

  add_index "projects", ["attachments_id"], name: "index_projects_on_attachments_id"
  add_index "projects", ["component_id"], name: "index_projects_on_component_id"
  add_index "projects", ["customer_id"], name: "index_projects_on_customer_id"
  add_index "projects", ["task_id"], name: "index_projects_on_task_id"
  add_index "projects", ["user_id"], name: "index_projects_on_user_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "finished"
    t.string   "user"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "attachments_id"
    t.integer  "historys_id"
  end

  add_index "tasks", ["attachments_id"], name: "index_tasks_on_attachments_id"
  add_index "tasks", ["historys_id"], name: "index_tasks_on_historys_id"
  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id"
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id"

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
    t.integer  "task_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["task_id"], name: "index_users_on_task_id"

end
