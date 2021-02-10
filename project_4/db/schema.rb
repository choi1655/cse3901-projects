# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_03_230331) do

  create_table "assignments", force: :cascade do |t|
    t.string "profile_id"
    t.string "class_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.integer "number"
    t.string "title"
    t.string "credits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["number"], name: "index_courses_on_number"
  end

  create_table "instructors", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_id"
    t.string "class_num"
    t.string "class_section"
  end

  create_table "mclasses", force: :cascade do |t|
    t.integer "number"
    t.integer "section"
    t.string "days"
    t.string "time"
    t.string "location"
    t.integer "enrolled"
    t.integer "limit"
    t.integer "waitlist"
    t.string "instructor"
    t.string "campus"
    t.boolean "need_grader"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "identity"
    t.string "firstName"
    t.string "lastName"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "approved"
  end

  create_table "recommendation_forms", force: :cascade do |t|
    t.string "instructor_id"
    t.string "content"
    t.string "application_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "student_applications", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile_id"
    t.string "class_ids"
    t.string "taken_course_ids"
    t.binary "resume"
    t.binary "advisor_report"
    t.string "days_times"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "newpassword"
  end

end
