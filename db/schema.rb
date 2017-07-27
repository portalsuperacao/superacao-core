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

ActiveRecord::Schema.define(version: 20170727212518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activation_codes", id: :serial, force: :cascade do |t|
    t.string "code"
    t.boolean "activated"
    t.datetime "activated_at"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_activation_codes_on_participant_id"
  end

  create_table "angel_configs", id: :serial, force: :cascade do |t|
    t.integer "supported_overcomers"
    t.text "welcome_message"
    t.integer "angel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["angel_id"], name: "index_angel_configs_on_angel_id"
  end

  create_table "cancer_treatments", id: :serial, force: :cascade do |t|
    t.integer "cancer_type_id"
    t.string "cancerous_type"
    t.integer "cancerous_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cancer_type_id"], name: "index_cancer_treatments_on_cancer_type_id"
    t.index ["cancerous_type", "cancerous_id"], name: "index_cancer_treatments_on_cancerous_type_and_cancerous_id"
  end

  create_table "cancer_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mission_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "deadline"
    t.json "guidance"
  end

  create_table "missions", id: :serial, force: :cascade do |t|
    t.integer "mission_type_id"
    t.integer "trinity_id"
    t.integer "participant_id"
    t.string "status", default: "new", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mission_type_id"], name: "index_missions_on_mission_type_id"
    t.index ["participant_id"], name: "index_missions_on_participant_id"
    t.index ["trinity_id"], name: "index_missions_on_trinity_id"
  end

  create_table "participant_profiles", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "occupation"
    t.string "country"
    t.string "state"
    t.string "city"
    t.decimal "lat"
    t.decimal "lng"
    t.string "relationship"
    t.integer "sons"
    t.string "facebook"
    t.string "instagram"
    t.string "whatsapp"
    t.string "youtube"
    t.string "snapchat"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "genre"
    t.string "email"
    t.string "belief"
    t.text "healing_quote"
    t.string "difficulty_quote"
    t.index ["participant_id"], name: "index_participant_profiles_on_participant_id"
  end

  create_table "participants", id: :serial, force: :cascade do |t|
    t.string "uid"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pacient"
    t.string "cancer_status"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "family_member"
  end

  create_table "positive_messages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "uploaded"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_profiles", id: :serial, force: :cascade do |t|
    t.integer "pacient"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_participant_id"
    t.integer "past_participant_id"
    t.boolean "metastasis"
    t.boolean "relapse"
    t.index ["current_participant_id"], name: "index_treatment_profiles_on_current_participant_id"
    t.index ["past_participant_id"], name: "index_treatment_profiles_on_past_participant_id"
  end

  create_table "treatment_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatments", id: :serial, force: :cascade do |t|
    t.integer "status"
    t.integer "treatment_type_id"
    t.string "treatable_type"
    t.integer "treatable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["treatable_type", "treatable_id"], name: "index_treatments_on_treatable_type_and_treatable_id"
    t.index ["treatment_type_id"], name: "index_treatments_on_treatment_type_id"
  end

  create_table "trinities", id: :serial, force: :cascade do |t|
    t.integer "overcomer_id"
    t.integer "angel_id"
    t.integer "archangel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["angel_id"], name: "index_trinities_on_angel_id"
    t.index ["archangel_id"], name: "index_trinities_on_archangel_id"
    t.index ["overcomer_id"], name: "index_trinities_on_overcomer_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "treatment_profiles", "participants", column: "current_participant_id"
  add_foreign_key "treatment_profiles", "participants", column: "past_participant_id"
end
