require "base64"

class InstructorViewController < ApplicationController

  before_action :is_instructor
  def index
    @title = "Instructor View"

    # this should be something like choi.1655
    @currentUsername = current_user.username

    # return profile for currently logged in user
    @currentProfile = findProfile(@currentUsername)
    # array of Instructors with current profile ID
    @instructors = Instructor.where(profile_id: @currentUsername)
    # array to store the courses list
    courses_arr = []
    for instructor in @instructors do
      # only append class number to the array if it does not exist in the arr
      unless courses_arr.include?(instructor.class_num)
        courses_arr << instructor.class_num
      end
    end
    application_ids = []
    #filter apps based on course_arr without duplicates
    allApps = StudentApplication.all
    allApps.each do |single|
      puts courses_arr
      unless((single.class_ids & courses_arr).empty?)
        unless(application_ids.include?(single.id))
          application_ids << single.id
        end
      end
    end
    puts "App id!!!!!!!!!!!!!!!!!"
    puts application_ids
    @applications = StudentApplication.where(id: application_ids)
    puts @currentUsername

  end

  # take in profile_id and return the Profile Object
  def findProfile(profile_id)
    # assuming there is only one profile with this profile_id
    @profile = Profile.where(identity: profile_id).first
    return @profile
  end

  # Take in [integer: [integer]] and return clean format of available time frames
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

  helper_method :formatAvailability
  helper_method :findProfile
end
