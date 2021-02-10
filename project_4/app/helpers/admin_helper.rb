require 'nokogiri'
require 'open-uri'

module AdminHelper
    def self.scrape_courses
        Course.delete_all
        url = 'http://coe-portal.cse.ohio-state.edu/pdf-exports/CSE/'
        html = URI.open(url)
        page = Nokogiri::HTML(html) { |conf| conf.noblanks }
        courses = page.xpath("//table")
        puts "Importing new data from: %s " % [url]
        count = 0
        courses.children.each_with_index do |row,index|
            if index!=0
                number = row.children[0].content
                title = row.children[4].content
                credits = row.children[6].content.squish
                new_course = Course.new(:number => number, :title => title, :credits => credits)
                new_course.save
            end
            count = index
        end
        puts "%i courses have been imported" % [count]
    end


    #The scrape method depends on using http requests to fetch the data from txt files in the following directory:
    #https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/
    #The data is processed using regex and then inserted into the database.
    #All the data is deleted when this method is called
    def self.scrape_classes(semester)
        require 'net/http'
        require 'uri'
        Mclass.delete_all
        url = "https://www.asc.ohio-state.edu/barrett.3/schedule/CSE/%s.txt" % [semester]
        puts "Importing new data from: %s " % [url]
        resp = Net::HTTP.get(URI(url))
        regex = /^ +CSE ([\d\.]+) +(LMA|MNS|MRN|NWK)? *(\d+) +([LBI]) +(\( *\d+\))? +([M ][T ][W ][R ][F ]) +([\w-]+)? +(\w+) +(\d+)\/(\d+) +(\+\d+)? +(\{7W2\})? *([^ \r\n][^\r\n]*)?$/
        resp.scan(regex) do |number,campus,section,idk2,number_alt,days,time,location,enrolled,limit,waitlist,half_semester,instructor|
            if !campus
                campus = "COL"
            end
            new_class = Mclass.new(:number => number, :section => section, :days => days, :time => time, :location => location, :enrolled => enrolled, :limit => limit, :waitlist => waitlist, :instructor => instructor, :campus => campus, :need_grader => false)
            new_class.save
        end
    end


    def self.createAdminUser(username,password)
        user = User.new(username: username, password: password, role: "admin")
        user.save
    end
end
