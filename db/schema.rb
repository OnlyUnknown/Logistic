# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_05_11_130810) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "tasks", default: [], array: true
    t.integer "phone_number"
    t.string "current_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.string "current_state"
    t.index ["email"], name: "index_agents_on_email", unique: true
    t.index ["id"], name: "index_agents_on_id", unique: true
    t.index ["jti"], name: "index_agents_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_agents_on_reset_password_token", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.integer "phone_number"
    t.string "tasks", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.string "availability"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["id"], name: "index_customers_on_id", unique: true
    t.index ["jti"], name: "index_customers_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower"
  end

  create_table "supervisions", force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.bigint "supervisor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_supervisions_on_agent_id"
    t.index ["supervisor_id", "agent_id"], name: "index_supervisions_on_supervisor_id_and_agent_id", unique: true
    t.index ["supervisor_id"], name: "index_supervisions_on_supervisor_id"
  end

  create_table "supervisors", force: :cascade do |t|
    t.string "name"
    t.string "tasks", default: [], array: true
    t.integer "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.index ["email"], name: "index_supervisors_on_email", unique: true
    t.index ["id"], name: "index_supervisors_on_id", unique: true
    t.index ["jti"], name: "index_supervisors_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_supervisors_on_reset_password_token", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "supervisor_id", null: false
    t.string "product"
    t.bigint "agent_id"
    t.integer "quantity"
    t.bigint "customer_id"
    t.string "status"
    t.float "price"
    t.integer "confirmation_code"
    t.string "current_location"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_tasks_on_agent_id"
    t.index ["customer_id"], name: "index_tasks_on_customer_id"
    t.index ["id"], name: "index_tasks_on_id", unique: true
    t.index ["supervisor_id"], name: "index_tasks_on_supervisor_id"
  end

  add_foreign_key "supervisions", "agents"
  add_foreign_key "supervisions", "supervisors"
  add_foreign_key "tasks", "agents"
  add_foreign_key "tasks", "customers"
  add_foreign_key "tasks", "supervisors"
end
