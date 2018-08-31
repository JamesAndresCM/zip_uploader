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

ActiveRecord::Schema.define(version: 2018_08_30_232341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_resources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "color"
    t.bigint "file_resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_resource_id"], name: "index_pets_on_file_resource_id"
    t.index ["name"], name: "index_pets_on_name"
  end

  create_table "products", force: :cascade do |t|
    t.integer "code"
    t.string "descripcion"
    t.integer "quantity"
    t.integer "valor"
    t.bigint "file_resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code"
    t.index ["file_resource_id"], name: "index_products_on_file_resource_id"
  end

  add_foreign_key "pets", "file_resources"
  add_foreign_key "products", "file_resources"
end
