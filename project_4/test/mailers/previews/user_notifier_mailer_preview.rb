# Preview all emails at http://localhost:3000/rails/mailers/user_notifier_mailer
class UserNotifierMailerPreview < ActionMailer::Preview
	
def send_signup_email
	# length=8
 #    source=("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
 #    key=""
 #    length.times{ key += source[rand(source.size)].to_s }
	# user = User.new(username: "dick.420", password: key, role: "student")

	
	# #UserNotifierMailer.send_signup_email(@user)
	# UserNotifierMailer.with(user: @user).send_signup_email
end

end
