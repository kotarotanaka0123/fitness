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

ActiveRecord::Schema.define(version: 2021_06_21_090722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "span"
    t.float "calorie"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "food_materials", force: :cascade do |t|
    t.bigint "food_id"
    t.bigint "materials_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_id"], name: "index_food_materials_on_food_id"
    t.index ["materials_id"], name: "index_food_materials_on_materials_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "protein", default: 0.0
    t.float "fat", default: 0.0
    t.float "carbon", default: 0.0
    t.float "fiber", default: 0.0
    t.float "vA", default: 0.0
    t.float "vE", default: 0.0
    t.float "vB1", default: 0.0
    t.float "vB2", default: 0.0
    t.float "vB6", default: 0.0
    t.float "niacin", default: 0.0
    t.float "yosan", default: 0.0
    t.float "panto", default: 0.0
    t.float "biotin", default: 0.0
    t.float "Na", default: 0.0
    t.float "K", default: 0.0
    t.float "Ca", default: 0.0
    t.float "Mg", default: 0.0
    t.float "P", default: 0.0
    t.float "Fe", default: 0.0
    t.float "Zn", default: 0.0
    t.float "Cu", default: 0.0
    t.float "Mn", default: 0.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_foods_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.float "slim"
    t.text "description"
    t.date "deadline"
    t.date "startday"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slim"], name: "index_goals_on_slim"
    t.index ["user_id"], name: "index_goals_on_user_id"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "protein", default: 0.0
    t.float "fat", default: 0.0
    t.float "carbon", default: 0.0
    t.float "fiber", default: 0.0
    t.float "vA", default: 0.0
    t.float "vE", default: 0.0
    t.float "vB1", default: 0.0
    t.float "vB2", default: 0.0
    t.float "vB6", default: 0.0
    t.float "niacin", default: 0.0
    t.float "yosan", default: 0.0
    t.float "panto", default: 0.0
    t.float "biotin", default: 0.0
    t.float "Na", default: 0.0
    t.float "K", default: 0.0
    t.float "Ca", default: 0.0
    t.float "Mg", default: 0.0
    t.float "P", default: 0.0
    t.float "Fe", default: 0.0
    t.float "Zn", default: 0.0
    t.float "Cu", default: 0.0
    t.float "Mn", default: 0.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_materials_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.float "weight"
    t.float "height"
    t.integer "age"
  end

  add_foreign_key "exercises", "users"
  add_foreign_key "food_materials", "foods"
  add_foreign_key "food_materials", "materials", column: "materials_id"
  add_foreign_key "goals", "users"
  add_foreign_key "materials", "users"
end
