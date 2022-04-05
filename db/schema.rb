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

ActiveRecord::Schema[7.0].define(version: 2022_04_05_111841) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
