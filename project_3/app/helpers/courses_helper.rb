module CoursesHelper

=begin
Converts the unformatted time to more human-readable format of time.
There can be only 3 types of possible pre-formatted time, XXXXA, XXXXA-XXXX,
and blank. The times are reformatted into hh:mma format.
=end
  def convert_time(unformatted_time)
    unformatted_time = unformatted_time.to_s
    if unformatted_time.length == 5
      return unformatted_time[0, 2] << ':' << unformatted_time[2, 3] << 'M'
    elsif unformatted_time.length == 0
      return 'N/A'
    else
      beginning_time = unformatted_time[0, 2] << ':' << unformatted_time[2, 3] << 'M'
      ending_time = unformatted_time[6, 2] << ':' << unformatted_time[8, 2]

      if beginning_time.end_with?('AM')
        beginning_hour = beginning_time[0, 2].to_i
        ending_hour = ending_time[0, 2].to_i
        if ending_hour != 12
          ending_hour = ending_hour + 12
        end
        difference = ending_hour - beginning_hour
        if difference < 5
          ending_time << 'PM'
        else
          ending_time << 'AM'
        end

      else
        ending_time << 'PM'
      end
      return beginning_time << '-' << ending_time
    end
  end
end
