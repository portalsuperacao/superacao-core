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

ActiveRecord::Schema.define(version: 20170112202226) do

  create_table "activation_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "code"
    t.boolean  "activated"
    t.date     "activated_at"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["participant_id"], name: "index_activation_codes_on_participant_id", using: :btree
  end

  create_table "angel_configs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "supported_overcomers"
    t.text     "welcome_message",      limit: 65535
    t.integer  "angel_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["angel_id"], name: "index_angel_configs_on_angel_id", using: :btree
  end

  create_table "cancer_treatments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cancer_type_id"
    t.string   "cancerous_type"
    t.integer  "cancerous_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["cancer_type_id"], name: "index_cancer_treatments_on_cancer_type_id", using: :btree
    t.index ["cancerous_type", "cancerous_id"], name: "index_cancer_treatments_on_cancerous_type_and_cancerous_id", using: :btree
  end

  create_table "cancer_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mission_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "deadline"
    t.json    "guidance"
  end

  create_table "missions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "mission_type_id"
    t.integer  "trinity_id"
    t.integer  "participant_id"
    t.string   "status",          default: "new", null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["mission_type_id"], name: "index_missions_on_mission_type_id", using: :btree
    t.index ["participant_id"], name: "index_missions_on_participant_id", using: :btree
    t.index ["trinity_id"], name: "index_missions_on_trinity_id", using: :btree
  end

  create_table "participant_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthdate"
    t.string   "occupation"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.decimal  "lat",            precision: 10
    t.decimal  "lng",            precision: 10
    t.string   "relationship"
    t.integer  "sons"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "whatsapp"
    t.string   "youtube"
    t.string   "snapchat"
    t.integer  "participant_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["participant_id"], name: "index_participant_profiles_on_participant_id", using: :btree
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treatment_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pacient"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["participant_id"], name: "index_treatment_profiles_on_participant_id", using: :btree
  end

  create_table "trinities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "overcomer_id"
    t.integer  "angel_id"
    t.integer  "archangel_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "status",       default: 0
    t.index ["angel_id"], name: "index_trinities_on_angel_id", using: :btree
    t.index ["archangel_id"], name: "index_trinities_on_archangel_id", using: :btree
    t.index ["overcomer_id"], name: "index_trinities_on_overcomer_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
