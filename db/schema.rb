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


ActiveRecord::Schema.define(version: 20140529104332) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fee_types", force: true do |t|
    t.string   "fee_type"
  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "fee_grade_buckets", force: true do |t|
    t.string   "grade_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_to"
  end

  create_table "grade_wise_fees", force: true do |t|
    t.integer  "fee_grade_bucket_id"
    t.integer  "fee_type_id"
    t.integer  "amount_in_rupees"
    t.string   "acedemic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monthly_pdc_amounts", force: true do |t|
    t.integer  "fee_grade_bucket_id"
    t.integer  "post_dated_cheque_id"
    t.integer  "amount_in_rupees"
    t.string   "academic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pg_search_documents", force: true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_dated_cheques", force: true do |t|
    t.date     "date"
    t.string   "month"
    t.integer  "academic_year"
    t.float    "amount_per"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "role"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "form_no"
    t.string   "name"
    t.string   "klass"
    t.string   "dob"
    t.string   "gender"
    t.string   "nationality"
    t.string   "language"
    t.string   "father_name"
    t.string   "mother_name"
    t.string   "father_occupation"
    t.string   "mother_occupation"
    t.string   "father_company"
    t.string   "mother_company"
    t.string   "father_education"
    t.string   "mother_education"
    t.string   "income"
    t.text     "address"
    t.string   "landline"
    t.string   "mobile"
    t.string   "email"
    t.string   "transport"
    t.string   "busstop"
    t.string   "last_school"
    t.string   "city"
    t.string   "changing_reason"
    t.string   "know_school"
    t.string   "person"
    t.string   "pp"
    t.string   "appno"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_definitions", force: true do |t|
    t.string   "term_definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount_per"
    t.string   "termdate"
  end

  create_table "term_wise_grade_fees", force: true do |t|
    t.integer  "fee_grade_bucket_id"
    t.integer  "term_definition_id"
    t.integer  "amount_in_rupees"
    t.string   "academic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.integer  "role_id"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
