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

ActiveRecord::Schema.define(version: 20160413072051) do

  create_table "components", force: :cascade do |t|
    t.string   "component_id_sap"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "customer_id"
  end

  add_index "components", ["customer_id"], name: "index_components_on_customer_id"

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "customer_id_sap"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "components_id"
  end

  add_index "customers", ["components_id"], name: "index_customers_on_components_id"

  create_table "project_items", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "start"
    t.datetime "end"
    t.datetime "finished"
    t.string   "user"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "project_id"
  end

  add_index "project_items", ["project_id"], name: "index_project_items_on_project_id"

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "component_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "projects", ["component_id"], name: "index_projects_on_component_id"

end
