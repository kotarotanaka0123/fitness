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

ActiveRecord::Schema.define(version: 2021_10_15_093105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.float "calorie", default: 0.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.integer "span"
    t.float "calorie"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
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

  create_table "group_users", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
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
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_likes_on_message_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "meal_ingredients", force: :cascade do |t|
    t.bigint "meal_id"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_meal_ingredients_on_ingredient_id"
    t.index ["meal_id"], name: "index_meal_ingredients_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "meal_type"
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
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.string "image"
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_messages_on_group_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "totals", force: :cascade do |t|
    t.string "name"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_totals_on_user_id"
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

  add_foreign_key "achievements", "users"
  add_foreign_key "exercises", "users"
  add_foreign_key "goals", "users"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "likes", "messages"
  add_foreign_key "likes", "users"
  add_foreign_key "meal_ingredients", "ingredients"
  add_foreign_key "meal_ingredients", "meals"
  add_foreign_key "messages", "groups"
  add_foreign_key "messages", "users"
end
