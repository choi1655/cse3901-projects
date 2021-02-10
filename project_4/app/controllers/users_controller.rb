#controller for user methods
class UsersController < ApplicationController

  #require user logs in
  skip_before_action :require_login, only: [:new, :create, :newinstr, :create_instr]
  
  #create new user
  def new
    
  end

  def newinstr
    
  end
  
  # creates student user
  def create

    #check if user is already in the db then redirect if need be
    if User.exists?(username: params[:username])    
      flash[:alert] = "User already exists!"
      redirect_to signup_path
    else  

      # create the user with input info
      @user = User.new(
        username: params[:username],
        password: '',
        role: "student"
      )

      @user.generate_password()
      
      #begin scraping OSU website for vcf file
      require 'net/http'
      require 'uri'
      url = "https://www.osu.edu/findpeople/" + params[:username] + "/vcard"
      resp = Net::HTTP.get(URI.parse(url))

      #Check if the response is valid vcf format
      if resp[0,6] == "BEGIN:"

        #start initializing profile for user
        @identity = params[:username]
        @approved = true
        
        #parse the vcf line by line and extract needed info
        resp.each_line do |line| 
          if (line[0,2] == "N:")
            helper = line.split(/:/,2).second
            @lastName = helper.split(/;/,2).first
          elsif (line[0,3] == "FN:")
            helper = line.split(/:/,2).second
            @firstName = helper.split(/ /,2).first
          elsif (line[0,6] == "TITLE:")
            # need to -3 to gir rid of /+/n in line
            @title = line.from(6).to(-3)
          end    
        end

        #helper prints to see whats happenening
        #delete when finished 
        puts @identity
        puts @approved
        puts @lastName
        puts @firstName
        puts @title
        puts @user.password
        #add changes into profile model
        @profile = Profile.new(
          :identity => @identity,
          :firstName => @firstName,
          :lastName => @lastName,
          :title => @title,
          :approved => @approved
        )
        #check if user is valid and then send out email to user and save
        if @user.valid?
          mailer = UserNotifierMailer.new.send_signup_email(@user)
          mailer.deliver
          #@user.password = BCrypt::Password.create(key)
          @user.save
          @profile.save        
          redirect_to @user
        else
          #user was not valid and internal error should be thrown
          flash[:alert] = "Unable to save user information."
          redirect_to signup_path
        end        
      else 
        # The user does not have a OSU account
        flash[:alert] = "The information you entered was invalid."
        redirect_to signup_path
        
      end

    end  
  end

  #create instructor, same flow as create but no email is generated
  #profile attribute approved is set to false
  def create_instr
    if User.exists?(username: params[:username])    
      flash[:alert] = "User already exists!"
      redirect_to signupinstr_path
    else  
      key= Passgen::generate
      info= Passgen::analyze(key)
      while info.complexity!="Strong"
        key= Passgen::generate
        info= Passgen::analyze(key)
      end  
      @user = User.new(
        username: params[:username],
        password: key,
        role: "instructor_pending"
      )
      #get the vcf
      require 'net/http'
      require 'uri'
      url = "https://www.osu.edu/findpeople/" + params[:username] + "/vcard"

      resp = Net::HTTP.get(URI.parse(url))
    
      if resp[0,6] == "BEGIN:"
        #get the profile info
        @identity = params[:username]
        @approved = false
        #parse the vcf
        resp.each_line do |line| 
          if (line[0,2] == "N:")
            helper = line.split(/:/,2).second
            @lastName = helper.split(/;/,2).first
          elsif (line[0,3] == "FN:")
            helper = line.split(/:/,2).second
            @firstName = helper.split(/ /,2).first
          elsif (line[0,6] == "TITLE:")
            # need to -3 to gir rid of /+/n in line
            @title = line.from(6).to(-3)
          end    
        end

        #for testing delete when finished
        puts @identity
        puts @approved
        puts @lastName
        puts @firstName
        puts @title
        puts @user.password
        #assign info to profile
        @profile = Profile.new(
          :identity => @identity,
          :firstName => @firstName,
          :lastName => @lastName,
          :title => @title,
          :approved => @approved
        )
        #save the user info and profile info to the database
        if @user.valid?
          @user.save
          @profile.save
          redirect_to @user
        else
          #error occured while saving user
          flash[:alert] = "Unable to save user information."
          redirect_to signupinstr_path
        end        
      else 
        #user doesn't have OSU credentials
        flash[:alert] = "The information you entered was invalid."
        redirect_to signupinstr_path
      end
    end
  end
  
  def change_password
    #@user = User.find(current_user.id)
    
    puts @user.username
    puts "!!!!!!!!!!!!!!!!!!!!!!!!"
    new_password = params[:newpassword]
    puts new_password
   
   if new_password != nil
     if @user && @user.authenticate(params[:password]) && params[:newpassword] != params[:password] && params[:newpassword].length > 5
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      @user.update_attribute(:password, new_password)
      flash[:success] = "Password Successfully changed"
      @user.newpassword = nil
      redirect_to @user
     else
      puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
      if new_password.length < 6
        flash[:alert] = "New password needs a length of 6"
      elsif params[:newpassword] == params[:password]
        flash[:alert] = "New password matches old password"
      else
        flash[:alert] = "Old password was incorrect"
      end
      redirect_to newpassword_path
      end
  
    else
     redirect_to newpassword_path
    end
    puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    puts @user.password
    puts "------------------------------------"
    puts @user.newpassword
  end
  #shows user their page and no one elses
  def show
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to @user
    end
  end  
end
