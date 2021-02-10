class CreateStudentApplications < ActiveRecord::Migration[6.0]
  def change
    create_table :student_applications do |t|

      t.timestamps
    end
  end
end
