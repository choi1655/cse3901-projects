class AddAttrToStudentApplication < ActiveRecord::Migration[6.0]
  def change
    add_column :student_applications, :profile_id, :string
    add_column :student_applications, :class_ids, :string
    add_column :student_applications, :taken_course_ids, :string
    add_column :student_applications, :weekly_days, :string
    add_column :student_applications, :weekly_times, :string
    add_column :student_applications, :resume, :string
    add_column :student_applications, :advisor_report, :string
  end
end
