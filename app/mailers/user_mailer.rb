class UserMailer < ApplicationMailer
	default from: 'rorsnippet@gmail.com'
	def welcome(user,token)
		@email = user
		@url  = "http://rorsnippet.herokuapp.com/confirmation/"+token
		mail(to: user,
		subject: 'Welcome to My Awesome Site')
	end

	def send_feedback(feedback)
		@feedback = feedback
		mail(to: @feedback.email, subject: 'Feedback for RoRSnippet')
		notify_feedback(@feedback)
	end

	def notify_feedback(feedback)
		@feedback = feedback
		mail(to: "sing.chow.ching@outlook.com;rorsnippet@gmail.com", subject: 'Feedback for RoRSnippet')
	end
end
