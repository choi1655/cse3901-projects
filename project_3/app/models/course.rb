class Course < ApplicationRecord

    #Filter methods to fetch data based on number,section, instructors
    scope :filter_by_number, -> (number) { where("number like ?", "%#{number}%")}
    scope :filter_by_section, -> (section) { where("section like ?", "#{section}%")}
    scope :filter_by_instructors, -> (instructors) { where("instructors like ?", "%#{instructors}%")}


    #The scrape method depends on using http requests to fetch the data from txt files in the following directory:
    #https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/
    #The data is processed using regex and then inserted into the database.
    #All the data is deleted when this method is called
    def self.scrape(semester)
        require 'net/http'
        require 'uri'
        Course.delete_all
        url = "https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/%s.txt" % [semester]
        puts "Importing new data from: %s " % [url]
        resp = Net::HTTP.get(URI(url))
        regex = /^ +CSE ([\d\.]+) +(LMA|MNS|MRN|NWK)? *(\d+) +([LBI]) +(\( *\d+\))? +([M ][T ][W ][R ][F ]) +([\w-]+)? +(\w+) +(\d+)\/(\d+) +(\+\d+)? +(\{7W2\})? *([^ \r\n][^\r\n]*)?$/
        resp.scan(regex) do |number,campus,section,idk2,number_alt,days,time,location,enrolled,limit,waitlist,half_semester,instructors|
            if !campus
                campus = "COL"
            end
            new_course = Course.new(:number => number, :section => section, :days => days, :time => time, :location => location, :enrolled => enrolled, :limit => limit, :waitlist => waitlist, :instructors => instructors, :campus => campus)
            new_course.save
        end
    end
end
