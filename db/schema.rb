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

ActiveRecord::Schema.define(version: 20150312114314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_terms", force: true do |t|
    t.string   "term_name"
    t.date     "from_date"
    t.date     "to_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activity_teachers_mappings", force: true do |t|
    t.integer  "activity_master_id"
    t.integer  "faculty_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adds", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.string   "dept"
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
    t.date     "dob"
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
    t.string   "sib_name1"
    t.string   "sib_age1"
    t.string   "sib_sex1"
    t.string   "sib_grade1"
    t.string   "sib_school1"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "form_no"
    t.string   "bus"
    t.string   "closestatus"
    t.string   "title"
    t.string   "description"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "faculty_id"
    t.string   "comment"
    t.string   "result"
    t.integer  "grade_master_id"
    t.string   "faculty"
    t.integer  "teacher_leader_id"
    t.string   "teachercomment"
    t.string   "finalresult"
    t.string   "sib_name2"
    t.string   "sib_age2"
    t.string   "sib_sex2"
    t.string   "sib_grade2"
    t.string   "sib_school2"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "previous_city"
    t.string   "pin"
    t.integer  "section_master_id"
    t.string   "father_nationality"
    t.string   "mother_nationality"
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

  create_table "assessment_criteria", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assessment_id"
    t.string   "assessment_criteria"
  end

  create_table "assessment_grade_mappings", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "assessment_type_id"
    t.integer  "no_of_times"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessment_listings", force: true do |t|
    t.integer  "faculty_master_id"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "subject_master_id"
    t.string   "assessment_desc"
    t.date     "assessment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assessment_id"
  end

  create_table "assessment_results", force: true do |t|
    t.integer  "assessment_listing_id"
    t.integer  "student_master_id"
    t.string   "assessment_result_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grading_master_id"
  end

  create_table "assessment_types", force: true do |t|
    t.string   "assessment_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assessments", force: true do |t|
    t.integer  "assessment_grade_mapping_id"
    t.integer  "subject_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assessment_name"
  end

  create_table "attendances", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "faculty_master_id"
    t.integer  "student_master_id"
    t.string   "attendance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "student_attendance"
    t.date     "attendance_date"
  end

  create_table "block_books", force: true do |t|
    t.string   "isbn"
    t.string   "blocked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
  end

  create_table "books", force: true do |t|
    t.string   "name"
    t.string   "isbn"
    t.string   "author"
    t.date     "year_of_publishing"
    t.string   "number_of_copies"
    t.date     "purchased_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "year"
    t.string   "book_type"
    t.string   "book_status"
  end

  create_table "canteen_managements", force: true do |t|
    t.string   "meal_name"
    t.string   "time"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canteenmanagers", force: true do |t|
    t.string   "breakfast"
    t.string   "lunch"
    t.string   "snacks"
    t.string   "dinner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "canteen_date"
  end

  create_table "class_teacher_mappings", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "faculty_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communication_mails", force: true do |t|
    t.integer  "from"
    t.integer  "to"
    t.integer  "message_id"
    t.boolean  "red"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_mail_id"
  end

  create_table "damagebooks", force: true do |t|
    t.string   "isbn"
    t.string   "book_stage"
    t.string   "damage_type"
    t.string   "damage_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "book_id"
  end

  create_table "day_ends", force: true do |t|
    t.date     "transaction_date"
    t.integer  "scrolled_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "default_allowance_deductions", force: true do |t|
    t.integer  "faculty_master_id"
    t.integer  "arrears_of_salary"
    t.integer  "incentive_payment"
    t.integer  "loyalty_deposit"
    t.integer  "grade_allowance"
    t.integer  "performance_bonus"
    t.integer  "additional_allowance_1"
    t.integer  "additional_allowance_2"
    t.integer  "additional_allowance_3"
    t.integer  "club_contribution"
    t.integer  "professional_tax"
    t.integer  "tds_pm"
    t.integer  "training_cost"
    t.integer  "notice_period_amount"
    t.integer  "additional_deduction_1"
    t.integer  "additional_deduction_2"
    t.integer  "additional_deduction_3"
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

  create_table "department_masters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designation_masters", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "managed_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", force: true do |t|
    t.string   "designation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "status"
    t.string   "enquiry_no"
  end

  create_table "donate_books", force: true do |t|
    t.integer  "book_id"
    t.string   "student_name"
    t.string   "grade_name"
    t.string   "section_name"
    t.date     "date_of_donation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donation_of_books", force: true do |t|
    t.string   "book_name"
    t.string   "isbn"
    t.string   "year_of_publishing"
    t.string   "number_of_copies"
    t.string   "book_type"
    t.string   "student_name"
    t.string   "section"
    t.string   "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employee_advance_payments", force: true do |t|
    t.integer  "faculty_master_id"
    t.date     "payment_date"
    t.integer  "amount_in_rupees"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employer_contributions", force: true do |t|
    t.integer  "payslip_id"
    t.integer  "faculty_master_id"
    t.integer  "pf"
    t.integer  "bonus_payment"
    t.date     "generated_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.integer  "admission_id"
    t.string   "title"
    t.text     "description"
    t.string   "staff"
    t.string   "grade"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "staff_id"
    t.string   "status"
    t.integer  "teacher_leader_id"
  end

  create_table "faculty_attendances", force: true do |t|
    t.integer  "faculty_master_id"
    t.string   "designation"
    t.string   "forenoon"
    t.string   "afternoon"
    t.string   "attendance_date"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type_of_leave"
    t.float    "pending_casual_leave"
    t.float    "pending_sick_leave"
    t.float    "max_casual_leave"
    t.float    "max_sick_leave"
  end

  create_table "faculty_leaves", force: true do |t|
    t.integer  "faculty_master_id"
    t.string   "month"
    t.integer  "lop"
    t.float    "days_worked"
    t.integer  "working_days"
    t.integer  "sl"
    t.integer  "pl"
    t.integer  "cl"
    t.string   "code"
    t.date     "entered_date"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculty_masters", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "faculty_name"
    t.string   "dob"
    t.string   "gender"
    t.string   "email"
    t.string   "mobile_no"
    t.string   "address"
    t.string   "nationality"
    t.string   "language"
    t.string   "primary_subject"
    t.string   "past_experience"
    t.string   "education_qualification"
    t.string   "dept"
    t.string   "post"
    t.integer  "role_id"
    t.string   "designation"
    t.integer  "designation_master_id"
    t.integer  "department_master_id"
    t.integer  "ctc"
    t.integer  "basic"
    t.integer  "special_allowance"
    t.date     "date_of_joining"
    t.date     "probation_date"
    t.date     "confirmation_date"
    t.date     "resignation_date"
    t.string   "status"
    t.string   "reason_for_resignation"
    t.string   "p_f_no"
    t.string   "bank_name"
    t.string   "account_number"
    t.string   "pan"
    t.string   "father_or_husband_name"
    t.string   "relation"
    t.string   "code"
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
    t.integer  "grade_from"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade_to"
  end

  create_table "fee_types", force: true do |t|
    t.string   "fee_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_wastages", force: true do |t|
    t.date     "current_date"
    t.integer  "wastage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "form24s", force: true do |t|
    t.integer  "quarter"
    t.string   "financial_year"
    t.string   "cheque_no"
    t.date     "created_date"
    t.string   "emp_status"
    t.integer  "month"
    t.integer  "year"
    t.date     "deposited_date"
    t.string   "challan_serial_no"
    t.string   "bsr_code"
    t.string   "payment_type"
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

  create_table "grade_books", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "no_of_books"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "grade_sections", force: true do |t|
    t.integer  "section_master_id"
    t.integer  "grade_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grade_subject_mappings", force: true do |t|
    t.integer  "subject_master_id"
    t.integer  "grade_master_id"
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

  create_table "grading_masters", force: true do |t|
    t.string   "grading_name"
    t.string   "grading_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guest_managements", force: true do |t|
    t.string   "guest_name"
    t.string   "guest_phone"
    t.text     "guest_address"
    t.string   "guest_email"
    t.string   "purpose"
    t.string   "follow_up"
    t.date     "follow_up_date"
    t.string   "came_to_meet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "holidaycalendars", force: true do |t|
    t.date     "holiday_date"
    t.string   "description"
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
    t.string   "status"
    t.string   "enquiry_no"
  end

  create_table "inventories", force: true do |t|
    t.string   "name"
    t.integer  "quantity"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "inventory_type"
    t.string   "status"
  end

  create_table "issuings", force: true do |t|
    t.string   "name"
    t.string   "grade"
    t.string   "section"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "book"
    t.integer  "student_master_id"
    t.datetime "deleted_at"
    t.date     "return"
    t.string   "book_return"
    t.string   "book_issue"
    t.integer  "book_id"
    t.date     "book_issue_date"
    t.date     "book_return_date"
  end

  add_index "issuings", ["deleted_at"], name: "index_issuings_on_deleted_at", using: :btree

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

  create_table "lab_criteria", force: true do |t|
    t.integer  "subject_master_id"
    t.string   "lab_criteria"
    t.integer  "grade_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lab_teacher_mappings", force: true do |t|
    t.integer  "subject_master_id"
    t.integer  "faculty_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_encashments", force: true do |t|
    t.integer  "faculty_master_id"
    t.date     "date"
    t.integer  "no_of_leaves_to_be_encashed"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leave_permissions", force: true do |t|
    t.integer  "faculty_master_id"
    t.string   "type_of_leave"
    t.string   "from_date"
    t.string   "to_date"
    t.string   "reason"
    t.string   "status"
    t.float    "bal_leave"
    t.float    "casual_leave_count"
    t.float    "sick_leave_count"
    t.integer  "faculty_attendance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "from_day"
    t.float    "to_day"
  end

  create_table "location_masters", force: true do |t|
    t.string   "location_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "route_id"
    t.boolean  "gmaps"
    t.integer  "index"
  end

  create_table "locations", force: true do |t|
    t.string   "location"
    t.integer  "sequence_no"
    t.integer  "route_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_master_id"
    t.boolean  "gmaps"
  end

  create_table "mealnames", force: true do |t|
    t.integer  "meal_type_id"
    t.string   "meal_detail_name"
    t.date     "canteen_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mealtype_id"
  end

  create_table "mealtypes", force: true do |t|
    t.string   "meal_type"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "medical_bills", force: true do |t|
    t.integer "faculty_master_id"
    t.integer "salary_tax_id"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.string  "attachment"
  end

  create_table "medical_insurances", force: true do |t|
    t.integer "faculty_master_id"
    t.integer "salary_tax_id"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.boolean "parent_included"
    t.boolean "parent_senior_citizen"
    t.string  "attachement"
  end

  create_table "messages", force: true do |t|
    t.string   "subject"
    t.text     "content"
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

  create_table "new_vehicles", force: true do |t|
    t.string   "model_no"
    t.string   "make_of_bus"
    t.date     "yom"
    t.string   "purchase_option"
    t.date     "purchase_option_date"
    t.integer  "capacity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "deleted_at"
    t.string   "year_of_manufacture"
  end

  add_index "new_vehicles", ["deleted_at"], name: "index_new_vehicles_on_deleted_at", using: :btree

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

  create_table "parent_masters", force: true do |t|
    t.string   "father_name"
    t.string   "mother_name"
    t.string   "father_mobile"
    t.string   "mother_mobile"
    t.string   "father_email"
    t.string   "mother_email"
    t.string   "father_office_address"
    t.string   "mother_office_address"
    t.string   "father_office_telephone"
    t.string   "mother_office_telephone"
    t.string   "father_religion"
    t.string   "mother_religion"
    t.string   "father_employer"
    t.string   "mother_employer"
    t.string   "father_occupation"
    t.string   "mother_occupation"
    t.string   "father_company"
    t.string   "mother_company"
    t.integer  "student_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "father_education"
    t.string   "mother_education"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "pin"
    t.integer  "user_id"
    t.string   "father_nationality"
    t.string   "mother_nationality"
    t.string   "state"
    t.string   "guardian_name"
    t.string   "guardian_email"
    t.string   "guardian_mobile"
    t.string   "guardian_occupation"
  end

  create_table "parent_payment_masters", force: true do |t|
    t.integer  "parent_master_id"
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

  create_table "payslip_additional_fields_labels", force: true do |t|
    t.integer "payslip_id"
    t.string  "additional_allowance_1"
    t.string  "additional_allowance_2"
    t.string  "additional_allowance_3"
    t.string  "additional_deduction_1"
    t.string  "additional_deduction_2"
    t.string  "additional_deduction_3"
  end

  create_table "payslips", force: true do |t|
    t.integer  "faculty_master_id"
    t.date     "generated_date"
    t.integer  "basic"
    t.integer  "hra"
    t.integer  "conveyance_allowance"
    t.integer  "city_compensatory_allowance"
    t.integer  "special_allowance"
    t.integer  "loyalty_allowance"
    t.integer  "medical_allowance"
    t.integer  "arrears_of_salary"
    t.integer  "incentive_payment"
    t.integer  "loyalty_deposit"
    t.integer  "grade_allowance"
    t.integer  "leave_settlement"
    t.integer  "performance_bonus"
    t.integer  "annual_bonus"
    t.integer  "additional_allowance_1"
    t.integer  "additional_allowance_2"
    t.integer  "additional_allowance_3"
    t.integer  "pf"
    t.integer  "club_contribution"
    t.integer  "professional_tax"
    t.integer  "tds_pm"
    t.integer  "training_cost"
    t.integer  "salary_advance"
    t.integer  "additional_deduction_1"
    t.integer  "additional_deduction_2"
    t.integer  "additional_deduction_3"
    t.integer  "notice_period_amount"
    t.integer  "labour_welfare_fund"
    t.integer  "voluntary_pf_contribution"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pf_statements", force: true do |t|
    t.integer  "faculty_master_id"
    t.integer  "payslip_id"
    t.integer  "epf_wages"
    t.integer  "eps_wages"
    t.integer  "epf_ee_share"
    t.integer  "epf_ee_remitted"
    t.integer  "eps_due"
    t.integer  "eps_remitted"
    t.integer  "diff_epf_and_eps"
    t.integer  "diff_remitted"
    t.integer  "n"
    t.integer  "refund_adv",        default: 0
    t.integer  "arrear_epf",        default: 0
    t.integer  "arrear_epf_ee",     default: 0
    t.integer  "arrear_epf_er",     default: 0
    t.integer  "arrear_eps",        default: 0
    t.integer  "job_run_id"
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

  create_table "principal_approvals", force: true do |t|
    t.string   "book_name"
    t.string   "author_name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recruitments", force: true do |t|
    t.string   "form_no"
    t.string   "name"
    t.string   "dob"
    t.string   "status"
    t.string   "staff_name"
    t.string   "description"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "educational_certificates"
    t.string   "previous_employment_proof"
    t.string   "salary_slips_for_previous_months"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_master_id"
    t.string   "closestatus"
    t.integer  "staff_admission_id"
    t.string   "comments"
    t.string   "staffhead"
    t.string   "final_result"
    t.string   "assessment_result"
    t.string   "management_result"
  end

  create_table "reminders", force: true do |t|
    t.string "description"
    t.date   "created_date"
    t.string "occurrence"
    t.date   "previous_resolution_date"
  end

  create_table "request_books", force: true do |t|
    t.string   "book_name"
    t.string   "author_name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "request_new_books", force: true do |t|
    t.string   "book_name"
    t.string   "author_name"
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

  create_table "routes", force: true do |t|
    t.string   "route_no"
    t.string   "no_of_stops"
    t.string   "lpp"
    t.string   "distance"
    t.integer  "busno_up"
    t.integer  "busno_down"
    t.integer  "no_of_children"
    t.integer  "sequence_no"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "deleted_at"
    t.boolean  "gmaps"
    t.string   "start_point"
    t.string   "end_point"
    t.string   "route_type"
    t.integer  "new_vehicle_id"
  end

  add_index "routes", ["deleted_at"], name: "index_routes_on_deleted_at", using: :btree

  create_table "salary_break_ups", force: true do |t|
    t.string   "component"
    t.string   "component_code"
    t.float    "criteria"
    t.string   "break_up_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "salary_taxes", force: true do |t|
    t.integer  "faculty_master_id"
    t.date     "financial_year_from"
    t.date     "financial_year_to"
    t.integer  "rent_per_month"
    t.string   "rent_receipt"
    t.integer  "standard_deduction"
    t.integer  "home_loan_interest"
    t.string   "home_loan_document"
    t.integer  "rent_received_per_month"
    t.integer  "other_tax"
    t.integer  "atg"
    t.string   "occupancy_type"
    t.integer  "employee_home_loan_interest"
    t.integer  "pt_and_wt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "savings", force: true do |t|
    t.integer "faculty_master_id"
    t.integer "salary_tax_id"
    t.string  "saving_type"
    t.integer "amount"
    t.string  "bill_no"
    t.date    "bill_date"
    t.string  "attachement"
  end

  create_table "section_masters", force: true do |t|
    t.string   "section_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "setup_masters", force: true do |t|
    t.float    "casual_leave"
    t.float    "sick_leave"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "designation"
  end

  create_table "special_day_transports", force: true do |t|
    t.string   "new_route_no"
    t.integer  "location_master_id"
    t.integer  "route_id"
    t.string   "new_up_route"
    t.string   "new_down_route"
    t.string   "new_busno_up"
    t.string   "new_busno_down"
    t.string   "time_up"
    t.string   "time_down"
    t.date     "date"
    t.string   "occation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "staff_admissions", force: true do |t|
    t.string   "form_no"
    t.string   "name"
    t.string   "dob"
    t.string   "gender"
    t.string   "email"
    t.string   "mobile_no"
    t.text     "address"
    t.string   "nationality"
    t.string   "klass"
    t.text     "language"
    t.string   "subject"
    t.string   "experience"
    t.string   "expected_salary"
    t.string   "education_qualification"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "post"
    t.integer  "staff_leader_id"
    t.string   "staffhead"
    t.string   "closestatus"
  end

  create_table "staff_leaders", force: true do |t|
    t.string   "heads"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffadmins", force: true do |t|
    t.string   "dept"
    t.string   "head"
    t.integer  "recruitment_id"
    t.integer  "staff_admission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "add_id"
    t.string   "post_role"
    t.integer  "faculty_master_id"
    t.integer  "role_id"
    t.integer  "staffrecruit_id"
  end

  create_table "staffrecruits", force: true do |t|
    t.string   "form_no"
    t.string   "faculty_name"
    t.string   "dob"
    t.string   "status"
    t.string   "staffhead"
    t.string   "description"
    t.string   "start_time"
    t.string   "end_time"
    t.string   "educational_certificates"
    t.string   "previous_employment_proof"
    t.string   "salary_slips_for_previous_months"
    t.string   "title"
    t.string   "subject_master_id"
    t.string   "closestatus"
    t.string   "staff_admission_id"
    t.string   "comments"
    t.string   "final_result"
    t.string   "assessment_result"
    t.string   "management_result"
    t.string   "gender"
    t.string   "email"
    t.string   "mobile_no"
    t.string   "address"
    t.string   "nationality"
    t.string   "klass"
    t.string   "language"
    t.string   "subject"
    t.string   "experience"
    t.string   "expected_salary"
    t.string   "education_qualification"
    t.string   "post"
    t.integer  "staff_leader_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "faculty_master_id"
    t.integer  "user_id"
    t.string   "dept"
    t.integer  "role_id"
    t.integer  "staffadmin_id"
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

  create_table "statuses", force: true do |t|
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_attendances", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "student_master_id"
    t.date     "date"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_masters", force: true do |t|
    t.string   "name"
    t.date     "dob"
    t.date     "joining_date"
    t.integer  "parent_master_id"
    t.string   "branch"
    t.string   "surname"
    t.string   "second_lang"
    t.string   "blood_group"
    t.string   "gender"
    t.string   "language"
    t.string   "admission_no"
    t.string   "allergy"
    t.string   "doctor_name"
    t.string   "doctor_mobile"
    t.string   "guardian_mobile"
    t.string   "guardian_name"
    t.string   "guardian_relationship"
    t.string   "middle_name"
    t.string   "nationality"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.boolean  "bus_facility"
    t.integer  "location_id"
    t.integer  "location_master_id"
  end

  create_table "student_route_mappings", force: true do |t|
    t.integer  "route_id"
    t.integer  "student_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_point"
    t.string   "pick_up_point"
    t.string   "drop_point"
    t.integer  "location_master_id"
    t.string   "lpp"
  end

  create_table "subject_grades", force: true do |t|
    t.string   "grade_master_id"
    t.string   "subject_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subject_masters", force: true do |t|
    t.string   "subject_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subject_type"
  end

  create_table "tax_buckets", force: true do |t|
    t.integer  "from"
    t.integer  "to"
    t.integer  "tax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teacher_grade_mappings", force: true do |t|
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "subject_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "faculty_master_id"
  end

  add_index "teacher_grade_mappings", ["faculty_master_id", "grade_master_id", "section_master_id", "subject_master_id"], name: "teacher_grade_map_index_1", unique: true, using: :btree

  create_table "teacher_leaders", force: true do |t|
    t.string   "admission_id"
    t.string   "klass"
    t.string   "faculty_leader"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "faculty_master_id"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
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
    t.string   "plan_month"
    t.string   "academic_year"
    t.date     "teaching_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "faculty_master_id"
    t.integer  "subject_master_id"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
  end

  create_table "term_definitions", force: true do |t|
    t.string   "term_definition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount_per"
    t.string   "termdate"
  end

  create_table "term_results", force: true do |t|
    t.integer  "academic_term_id"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "student_master_id"
    t.integer  "assessment_criteria_id"
    t.integer  "grading_master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_master_id"
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
    t.integer  "mon_sub"
    t.integer  "tue_sub"
    t.integer  "wed_sub"
    t.integer  "thu_sub"
    t.integer  "fri_sub"
    t.integer  "sat_sub"
    t.integer  "sun_sub"
    t.time     "st_time"
    t.time     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade_master_id"
    t.integer  "section_master_id"
    t.integer  "period_id"
  end

  create_table "user_mails", force: true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
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

  create_table "vendor_categories", force: true do |t|
    t.string   "vendor_category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_managements", force: true do |t|
    t.string   "vendor_name"
    t.integer  "vendor_categories_id"
    t.string   "vendor_phone"
    t.string   "vendor_email"
    t.string   "vendor_alternate_email"
    t.text     "vendor_address"
    t.string   "verdor_mobile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "vendor_category_id"
    t.string   "contact_name"
  end

end
