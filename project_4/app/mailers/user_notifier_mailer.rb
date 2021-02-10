class UserNotifierMailer < ApplicationMailer
	


	def send_signup_email(user)
		#@user = user
		 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!"
		 puts user
		 puts user.username
		 puts user.password
		 puts user.role
		 helper = user.username+"@osu.edu"
		 puts helper
		mail(to: helper, subject: "OSU Hiring Portal Request temporary password", body: "Your temp password is: #{user.password}\nPlease change your password once you log in")
	end

end
