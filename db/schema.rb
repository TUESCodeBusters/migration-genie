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

ActiveRecord::Schema.define(version: 20170430060254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.datetime "checkedOn"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.decimal  "lat",         precision: 10, scale: 6
    t.decimal  "lng",         precision: 10, scale: 6
    t.integer  "sighting_id"
  end

  create_table "sightings", force: :cascade do |t|
    t.datetime "capturedOn"
    t.integer  "objects"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "photo"
    t.integer  "user_id"
    t.integer  "location_id"
    t.integer  "species_id"
    t.string   "photo_cdn"
    t.index ["location_id"], name: "index_sightings_on_location_id", using: :btree
    t.index ["species_id"], name: "index_sightings_on_species_id", using: :btree
    t.index ["user_id"], name: "index_sightings_on_user_id", using: :btree
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "location_id"
    t.integer  "sightings_id"
    t.integer  "sighting_id"
    t.index ["location_id"], name: "index_species_on_location_id", using: :btree
    t.index ["name"], name: "index_species_on_name", unique: true, using: :btree
    t.index ["sightings_id"], name: "index_species_on_sightings_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "sightings", "locations"
  add_foreign_key "sightings", "species"
  add_foreign_key "sightings", "users"
  add_foreign_key "species", "locations"
  add_foreign_key "species", "sightings", column: "sightings_id"
end
