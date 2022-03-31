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

ActiveRecord::Schema[7.0].define(version: 2022_03_31_073541) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exam_requests", force: :cascade do |t|
    t.bigint "exam_id"
    t.bigint "user_id"
    t.string "name"
    t.text "details"
    t.jsonb "text_items"
    t.boolean "shared"
    t.integer "shared_by_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_requests_on_exam_id"
    t.index ["shared_by_id"], name: "index_exam_requests_on_shared_by_id"
    t.index ["updated_by_id"], name: "index_exam_requests_on_updated_by_id"
    t.index ["user_id"], name: "index_exam_requests_on_user_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "starts_on", null: false
    t.datetime "ends_on", null: false
    t.datetime "completed_at"
    t.string "share_uuid"
    t.string "status", default: "inprogress"
    t.bigint "user_id"
    t.integer "updated_by_id"
    t.integer "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_exams_on_business_id"
    t.index ["share_uuid"], name: "index_exams_on_share_uuid"
    t.index ["updated_by_id"], name: "index_exams_on_updated_by_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
