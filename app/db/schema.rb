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

ActiveRecord::Schema.define(version: 20160818030901) do

  create_table "activation_codes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "code"
    t.boolean  "activated"
    t.date     "activated_at"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["participant_id"], name: "index_activation_codes_on_participant_id", using: :btree
  end

  create_table "participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "name"
    t.string   "uid"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trinities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "overcomer_id"
    t.integer  "angel_id"
    t.integer  "archangel_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["angel_id"], name: "index_trinities_on_angel_id", using: :btree
    t.index ["archangel_id"], name: "index_trinities_on_archangel_id", using: :btree
    t.index ["overcomer_id"], name: "index_trinities_on_overcomer_id", using: :btree
  end

end
