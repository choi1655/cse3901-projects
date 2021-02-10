class StudentApplicationController < ApplicationController
  before_action :is_student  
  
  def index
      @currentUsername = current_user.username
      @mclass = Mclass.where(need_grader: true)
      @student = StudentApplication.find_by(profile_id:current_user.username)
      #puts JSON.parse(@student.days_times)
      if (@student==nil)
        @student=StudentApplication.new
      end
      @weeks = Hash.new("weeks")
      @weeks = {1=>"Mon",2=>"Tue",3=>"Wed",4=>"Thu",5=>"Fri",6=>"Sat",7=>"Sun"}
    end

    def create
      if (params[:times]==nil)
        redirect_to url_for(controller: 'student_application', action: 'index'), alert: "dates times is not null!"
      end
      if (params[:person][:class_ids]==nil )
        redirect_to url_for(controller: 'student_application', action: 'index'), alert: "class ids is not null!"
      end
      if (params[:person][:taken_course_ids]==nil )
        redirect_to url_for(controller: 'student_application', action: 'index'), alert: "taken course ids is not null!"
      end
      student = StudentApplication.find_by(:profile_id =>  current_user.username)
      if (student==nil)
        student = StudentApplication.new
      end
      student.profile_id=current_user.username
      if params[:advisor_report]
        student.advisor_report=params[:advisor_report].read
      end
      if params[:resume]
        student.resume=params[:resume].read
      end
      student.class_ids=params[:person][:class_ids].reject(&:blank?)
      student.taken_course_ids=params[:person][:taken_course_ids].reject(&:blank?)
      student.days_times=params[:times]
      student.save!
      redirect_to url_for(ontroller: 'student_application', action: 'index'), info: "save ok"
    end
end
