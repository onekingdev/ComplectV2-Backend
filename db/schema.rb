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

ActiveRecord::Schema[7.0].define(version: 2022_04_11_215519) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "business_name"
    t.string "crd"
    t.integer "aum"
    t.integer "accounts"
    t.string "time_zone"
    t.string "phone_number"
    t.string "website"
    t.string "address"
    t.string "apt_unit"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.bigint "user_id"
    t.jsonb "logo_data"
    t.integer "payment_method_id"
    t.string "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "invite_email"
    t.datetime "start_date"
    t.datetime "disabled_at"
    t.string "disabled_reason"
    t.text "additional_reason"
    t.boolean "access_person"
    t.string "role"
    t.boolean "active"
    t.string "invite_hash"
    t.bigint "user_id"
    t.bigint "business_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_employees_on_business_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

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

  create_table "policies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "position"
    t.string "status", default: "draft"
    t.integer "src_id"
    t.datetime "published_at"
    t.integer "published_by_id"
    t.datetime "archived_at"
    t.integer "archived_by_id"
    t.integer "business_id"
    t.bigint "user_id"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived_by_id"], name: "index_policies_on_archived_by_id"
    t.index ["business_id"], name: "index_policies_on_business_id"
    t.index ["published_by_id"], name: "index_policies_on_published_by_id"
    t.index ["src_id"], name: "index_policies_on_src_id"
    t.index ["updated_by_id"], name: "index_policies_on_updated_by_id"
    t.index ["user_id"], name: "index_policies_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.bigint "user_id"
    t.string "time_zone"
    t.string "address"
    t.string "apt_unit"
    t.string "city"
    t.string "state"
    t.string "phone_number"
    t.string "zipcode"
    t.boolean "availability"
    t.boolean "former_regulator"
    t.decimal "hourly_rate"
    t.jsonb "avatar_data"
    t.jsonb "file_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "experience"
    t.boolean "show_full_name"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "risk_policies", force: :cascade do |t|
    t.bigint "risk_id"
    t.bigint "policy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["policy_id"], name: "index_risk_policies_on_policy_id"
    t.index ["risk_id"], name: "index_risk_policies_on_risk_id"
  end

  create_table "risks", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id"
    t.integer "updated_by_id"
    t.integer "business_id"
    t.string "impact"
    t.string "likelihood"
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["business_id"], name: "index_risks_on_business_id"
    t.index ["updated_by_id"], name: "index_risks_on_updated_by_id"
    t.index ["user_id"], name: "index_risks_on_user_id"
  end

  create_table "share_exams", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "exam_id"
    t.string "invited_email"
    t.string "otp"
    t.datetime "otp_requested"
    t.datetime "viewed_at"
    t.integer "updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_share_exams_on_exam_id"
    t.index ["updated_by_id"], name: "index_share_exams_on_updated_by_id"
    t.index ["user_id"], name: "index_share_exams_on_user_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.text "otp_secret"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login", default: true
    t.string "kind"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_experiences", force: :cascade do |t|
    t.bigint "profile_id"
    t.string "title", null: false
    t.string "employer", null: false
    t.text "description"
    t.datetime "starts_on", null: false
    t.datetime "ends_on"
    t.boolean "is_present"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_work_experiences_on_profile_id"
  end

  add_foreign_key "taggings", "tags"
end
