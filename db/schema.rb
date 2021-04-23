# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_18_023638) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", primary_key: "uid", id: :string, force: :cascade do |t|
    t.string "user_uid"
    t.integer "type_event"
    t.integer "size"
    t.string "organization"
    t.string "description"
    t.integer "status", default: 0, null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "event_name"
    t.index ["uid"], name: "index_events_on_uid", unique: true
  end

  create_table "take_part_in_events", primary_key: "uid", id: :string, force: :cascade do |t|
    t.string "user_uid"
    t.string "event_uid"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_take_part_in_events_on_uid", unique: true
  end

  create_table "tokens", force: :cascade do |t|
    t.string "qr_code_id"
    t.string "qr_code_type"
    t.string "qr_code_string"
    t.integer "status"
    t.datetime "expired_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["qr_code_id"], name: "index_tokens_on_qr_code_id", unique: true
    t.index ["qr_code_string"], name: "index_tokens_on_qr_code_string", unique: true
  end

  create_table "users", primary_key: "uid", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "email"
    t.string "hashed_password"
    t.string "phone"
    t.integer "status"
    t.integer "gender"
    t.date "birthday"
    t.text "class_activity"
    t.string "id_student"
    t.string "id_lecturer"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["uid"], name: "index_users_on_uid", unique: true
  end

  add_foreign_key "events", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  add_foreign_key "take_part_in_events", "events", column: "event_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
  add_foreign_key "take_part_in_events", "users", column: "user_uid", primary_key: "uid", on_update: :cascade, on_delete: :cascade
end
