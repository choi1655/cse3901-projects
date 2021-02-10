class StudentApplication < ApplicationRecord
    scope :filter_by_student, -> (student_id) { where("profile_id like ?", "%#{student_id}%")}



    serialize :class_ids, Array
    serialize :taken_course_ids, Array
    serialize :days_times, JSON
   
end
