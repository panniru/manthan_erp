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

ActiveRecord::Schema.define(version: 20140702075040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adds", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admissions", force: true do |t|
    t.string   "admission_no"
    t.string   "branch"
    t.string   "surname"
    t.string   "second_lang"
    t.string   "board"
    t.string   "grade"
    t.string   "medium"
    t.integer  "year"
    t.string   "written"
    t.string   "reading"
    t.string   "spoken"
    t.string   "blood_group"
    t.string   "allergy"
    t.string   "doctor_name"
    t.string   "doctor_mobile"
    t.string   "guardian_name"
    t.string   "guardian_mobile"
    t.string   "guardian_relationship"
    t.string   "from"
    t.string   "to"
    t.string   "middle_name"
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
    t.string   "status"
    t.string   "father_office_address"
    t.string   "mother_office_address"
    t.string   "father_office_telephone"
    t.string   "mother_office_telephone"
    t.string   "father_mobile"
    t.string   "mother_mobile"
    t.string   "mother_religion"
    t.string   "father_religion"
    t.string   "father_employer"
    t.string   "mother_employer"
    t.string   "father_email"
    t.string   "mother_email"
    t.string   "sib_name"
    t.string   "sib_age"
    t.string   "sib_sex"
    t.string   "sib_grade"
    t.string   "sib_school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "bus"
    t.string   "form_no"
    t.string   "closestatus"
  end

  create_table "approval_items", force: true do |t|
    t.string   "status"
    t.string   "academic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_type"
    t.integer  "defined_by"
    t.integer  "approved_by"
  end

  create_table "approvals", force: true do |t|
    t.string   "approved"
    t.string   "def_by"
    t.string   "status"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_masters", force: true do |t|
    t.string   "default_name"
    t.string   "default_value"
    t.string   "default_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "discounts", force: true do |t|
    t.float    "discount_percent"
    t.string   "academic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documentuploaders", force: true do |t|
    t.string   "name"
    t.string   "educational_certificates"
    t.string   "previous_employment_proof"
    t.string   "salary_slips_for_previous_months"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "staff"
    t.string   "grade"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "staff_id"
  end

  create_table "faculty_masters", force: true do |t|
    t.integer  "user_id"
    t.string   "faculty_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fee_alert_failures", force: true do |t|
    t.string   "e_mail"
    t.integer  "job_run_id"
    t.string   "remarks"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fee_grade_buckets", force: true do |t|
    t.string   "grade_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_to"
  end

  create_table "fee_types", force: true do |t|
    t.string   "fee_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", force: true do |t|
    t.string   "name"
    t.string   "dob"
    t.string   "gender"
    t.string   "email"
    t.string   "mobile_no"
    t.string   "address"
    t.string   "language"
    t.string   "experience"
    t.string   "klass"
    t.string   "subject"
    t.string   "education_qualification"
    t.string   "expected_salary"
    t.string   "nationality"
    t.string   "post"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "enquiry_no"
    t.string   "status"
  end

  create_table "grade_bucket_mappings", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "fee_grade_bucket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_masters", force: true do |t|
    t.string   "grade_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_wise_fees", force: true do |t|
    t.integer  "fee_grade_bucket_id"
    t.integer  "fee_type_id"
    t.integer  "amount_in_rupees"
    t.string   "acedemic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interviewschedulers", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_runs", force: true do |t|
    t.integer  "job_id"
    t.datetime "started_on"
    t.datetime "finished_on"
    t.string   "status"
    t.string   "scrolled_by"
    t.date     "job_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", force: true do |t|
    t.string   "code"
    t.string   "description"
    t.string   "job_type"
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

  create_table "parent_cheques", force: true do |t|
    t.integer  "parent_payment_transaction_id"
    t.string   "cheque_number"
    t.date     "cheque_date"
    t.string   "status"
    t.integer  "post_dated_cheque_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bank_name"
    t.string   "ifsc_code"
    t.integer  "term_definition_id"
  end

  create_table "parent_payment_masters", force: true do |t|
    t.integer  "parent_id"
    t.integer  "student_id"
    t.integer  "payment_type_id"
    t.date     "next_payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parent_payment_transactions", force: true do |t|
    t.integer  "parent_payment_master_id"
    t.date     "transaction_date"
    t.integer  "amount_in_rupees"
    t.string   "transaction_type"
    t.string   "particulars"
    t.string   "academic_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_definition_id"
    t.string   "status"
  end

  create_table "parents", force: true do |t|
    t.string   "father_name"
    t.string   "mother_name"
    t.string   "guardian_name"
    t.string   "father_occupation"
    t.string   "mother_occupation"
    t.string   "guardian_occupation"
    t.string   "father_phone"
    t.string   "mother_phone"
    t.string   "guardian_phone"
    t.string   "father_email"
    t.string   "mother_email"
    t.string   "guardian_email"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "payment_receipts", force: true do |t|
    t.string   "code"
    t.integer  "parent_payment_transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_types", force: true do |t|
    t.string   "code"
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

  create_table "recruitments", force: true do |t|
    t.string   "title"
    t.string   "education_details"
    t.string   "experience"
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

  create_table "section_masters", force: true do |t|
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_master_id"
  end

  create_table "staffs", force: true do |t|
    t.string   "staff_name"
    t.string   "staff_exp"
    t.string   "grade"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "period"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_masters", force: true do |t|
    t.string   "name"
    t.date     "dob"
    t.date     "joining_date"
    t.string   "academic_year"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.boolean  "bus_facility"
  end

  create_table "subject_masters", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_grade_mappings", force: true do |t|
    t.string   "grade_master_id"
    t.string   "section_master_id"
    t.string   "subject_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "faculty_master_id"
  end

  create_table "teachers_time_tables", force: true do |t|
    t.integer  "faculty_master_id"
    t.string   "academic_year"
    t.integer  "period_id"
    t.string   "mon_grade_section"
    t.string   "tue_grade_section"
    t.string   "wed_grade_section"
    t.string   "thu_grade_section"
    t.string   "fri_grade_section"
    t.string   "sat_grade_section"
    t.string   "sun_grade_section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teaching_plans", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_master_id"
    t.string   "section_master_id"
    t.string   "plan"
    t.date     "teaching_date"
    t.string   "plan_month"
    t.integer  "user_id"
    t.string   "academic_year"

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

  create_table "tests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_tables", force: true do |t|
    t.string   "academic_year"
    t.string   "staffid"
    t.string   "mon_sub"
    t.string   "tue_sub"
    t.string   "wed_sub"
    t.string   "thu_sub"
    t.string   "fri_sub"
    t.string   "sat_sub"
    t.string   "sun_sub"
    t.time     "st_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade_master_id"
    t.string   "section_master_id"
    t.integer  "period_id"
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
