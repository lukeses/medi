# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150923125615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "admins", ["user_id"], name: "index_admins_on_user_id", using: :btree

  create_table "clinics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.integer  "pwz"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "doctors", ["user_id"], name: "index_doctors_on_user_id", using: :btree

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "patients", ["user_id"], name: "index_patients_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "pesel"
    t.string   "address"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.boolean  "approved"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visits", force: :cascade do |t|
    t.datetime "start"
    t.datetime "finish"
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.integer  "clinic_id"
    t.boolean  "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "visits", ["clinic_id"], name: "index_visits_on_clinic_id", using: :btree
  add_index "visits", ["doctor_id"], name: "index_visits_on_doctor_id", using: :btree
  add_index "visits", ["patient_id"], name: "index_visits_on_patient_id", using: :btree

  create_table "workhours", force: :cascade do |t|
    t.integer  "weekday"
    t.time     "start"
    t.time     "finish"
    t.integer  "work_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "workhours", ["work_id"], name: "index_workhours_on_work_id", using: :btree

  create_table "works", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "clinic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "works", ["clinic_id"], name: "index_works_on_clinic_id", using: :btree
  add_index "works", ["doctor_id"], name: "index_works_on_doctor_id", using: :btree

  add_foreign_key "admins", "users"
  add_foreign_key "doctors", "users"
  add_foreign_key "patients", "users"
  add_foreign_key "visits", "clinics"
  add_foreign_key "visits", "doctors"
  add_foreign_key "visits", "patients"
  add_foreign_key "workhours", "works"
  add_foreign_key "works", "clinics"
  add_foreign_key "works", "doctors"
end
