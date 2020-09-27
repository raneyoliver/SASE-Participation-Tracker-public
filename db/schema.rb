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

ActiveRecord::Schema.define(version: 2020_09_22_205344) do
ActiveRecord::Schema.define(version: 2020_09_24_125928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reset_password_token"], name: "index_admin_on_reset_password_token", unique: true
    t.index ["username"], name: "index_admin_on_username", unique: true
  end

  create_table "event", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "form", id: :string, force: :cascade do |t|
    t.integer "event_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "form_type"
    t.string "questions"
  end

  create_table "form_user", force: :cascade do |t|
    t.string "form_id", null: false
    t.string "user_id", null: false
  end

  create_table "user", id: :string, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "major", null: false
    t.integer "graduation_year", null: false
    t.string "email", null: false
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
