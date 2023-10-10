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

ActiveRecord::Schema[7.0].define(version: 2023_10_10_144113) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultation_requests", force: :cascade do |t|
    t.text "text"
    t.bigint "patient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_consultation_requests_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "full_name"
    t.date "date_of_birth"
    t.string "phone_number"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommendations", force: :cascade do |t|
    t.text "text"
    t.bigint "consultation_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["consultation_request_id"], name: "index_recommendations_on_consultation_request_id"
  end

  add_foreign_key "consultation_requests", "patients"
  add_foreign_key "recommendations", "consultation_requests"
end
