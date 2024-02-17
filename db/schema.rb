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

ActiveRecord::Schema[7.0].define(version: 2024_02_14_131115) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "tasks", default: [], array: true
    t.integer "phone_number"
    t.string "current_location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_agents_on_id", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.integer "phone_number"
    t.string "tasks", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_customers_on_id", unique: true
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
    t.index ["id"], name: "index_supervisors_on_id", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "supervisor_id", null: false
    t.string "product"
    t.string "sender"
    t.integer "quantity"
    t.integer "receiver"
    t.string "status"
    t.float "price"
    t.string "current_location"
    t.float "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supervisor_id"], name: "index_tasks_on_supervisor_id"
  end

  add_foreign_key "supervisions", "agents"
  add_foreign_key "supervisions", "supervisors"
  add_foreign_key "tasks", "supervisors"
end
