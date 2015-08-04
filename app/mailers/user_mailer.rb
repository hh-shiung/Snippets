class UserMailer < ApplicationMailer
	default from: 'LetYouWinLa@RORSnippets.com'
	def welcome(user,token)
		@email = user
		@url  = "http://rorsnippet.herokuapp.com/confirmation/"+token
		mail(to: user,
		subject: 'Welcome to My Awesome Site')
	end
end
