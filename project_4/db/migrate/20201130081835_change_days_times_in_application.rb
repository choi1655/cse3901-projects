class ChangeDaysTimesInApplication < ActiveRecord::Migration[6.0]
  def change
    change_column :student_applications,:resume,:binary
    change_column :student_applications,:advisor_report,:binary
    add_column :student_applications,:days_times,:string
    remove_column :student_applications,:weekly_days
    remove_column :student_applications,:weekly_times
  end
end
