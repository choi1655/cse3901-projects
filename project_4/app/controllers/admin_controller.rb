

class AdminController < ApplicationController
  include AdminHelper
  helper_method :findProfile, :formatAvailability
  before_action :is_admin
  def applications
    @apps = StudentApplication.all
    @apps = @apps.filter_by_student(params[:student_id]) if params[:student_id].present?
  end

  def users
    @users = User.all
  end

  def classes
    @classes = Mclass.all
  end

  def rec_display
    @recs = RecommendationForm.where(application_id: params[:student])
  end

  def assign_student
    @student = params[:student]
    @selected_class_id = 0
    unless(Assignment.where(profile_id: @student).empty?)
      @selected_class_id = Assignment.where(profile_id: @student).first.class_id
    end
  end

  def assign
    assignment = Assignment.new
    unless(Assignment.where(profile_id: params[:student]).empty?)
      assignment = Assignment.where(profile_id: params[:student]).first
    end
    assignment.profile_id = params[:student]
    assignment.class_id = params[:data][:class_id]
    if(params[:data][:class_id].empty?)
      assignment.destroy
    else
      assignment.save
    end
    redirect_to :controller => 'admin', :action => 'applications'
  end

  def reset_password
    user = User.find(params[:data][:id])
    puts("Resetting password for user " + user.username)

    user.generate_password()
    user.save

    mailer = UserNotifierMailer.new.send_signup_email(user)
    mailer.deliver


    redirect_to :action => 'users'
  end

  def approve_instructor
    user = User.find(params[:data][:id])
    if user.role == 'instructor_pending' then
      puts("Approving user " + user.username)

      user.generate_password()

      mailer = UserNotifierMailer.new.send_signup_email(user)
      mailer.deliver

      user.update!({:role => 'instructor'})
    end

    redirect_to :action => 'users'
  end


  ###Move this to app helper or controler
  def formatAvailability(data)
    result = ""
    data.each do |day, time_list|
      # determine the day
      case day
      when "1"
        result += "Monday: "
      when "2"
        result += "Tuesday: "
      when "3"
        result += "Wednesday: "
      when "4"
        result += "Thursday: "
      when "5"
        result += "Friday: "
      when "6"
        result += "Saturday: "
      when "7"
        result += "Sunday: "
      end

      for time in time_list do
        result += "#{format24Hour(time)} "
      end
    end
    return result
  end

  def format24Hour(hour)
    hour = hour.to_i
    if hour == 0
      return "12AM"
    end
    if hour >= 1 && hour <= 11
      return "#{hour}AM"
    else
      time = hour - 12
      if time == 0
        return "12PM"
      else
        return "#{hour - 12}PM"
      end
    end
  end
  def findProfile(profile_id)
    # assuming there is only one profile with this profile_id
    @profile = Profile.where(identity: profile_id).first
    return @profile
  end

  def requires_graders
    mclass = Mclass.find(params[:data][:id])
    mclass.update({:need_grader => !mclass.need_grader})

    redirect_to :action => 'classes'
  end

  def instructor_selection()
    @mclass = Mclass.find(params[:class_id])
  end

  def select_instructor()
    mclass = Mclass.find(params[:mclass_id])
    user = User.find(params[:data][:class_id])
    inst = Instructor.new(
      profile_id: user.username,
      class_num: mclass.number,
      class_section: mclass.section
    )
    inst.save

    redirect_to :action => 'classes'
  end
end
