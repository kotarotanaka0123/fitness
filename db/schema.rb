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

ActiveRecord::Schema.define(version: 2022_01_29_062359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.float "calorie", default: 0.0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "latest_time"
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

  create_table "add_user_to_groups", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.boolean "activation", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "describe"
    t.integer "owner_id", default: 0
    t.string "image"
    t.index ["name"], name: "index_groups_on_name", unique: true
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
    t.string "description"
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

  create_table "payments", force: :cascade do |t|
    t.string "email"
    t.text "description"
    t.string "currency"
    t.string "customer_id"
    t.date "payment_date"
    t.string "payment_status"
    t.string "uuid"
    t.string "charge_id"
    t.float "stripe_commission"
    t.float "amount_after_subtract_commission"
    t.string "receipt_url"
    t.string "product_id"
    t.string "product_name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "temp_users", force: :cascade do |t|
    t.string "mail_address", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "token", limit: 64, null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mail_address"], name: "index_temp_users_on_mail_address", unique: true
    t.index ["token"], name: "index_temp_users_on_token", unique: true
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
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.float "weight"
    t.float "height"
    t.integer "age"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "image"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
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
