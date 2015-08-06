class DisplayController < ApplicationController

	def showIndex
		render template: 'landing/index'
	end

	def showLogin
		render template: 'users/login'
	end

	def showLock
		render template: 'users/lock_screen'
	end

	private
	def auth_user
		puts "auth_user from Display"
		if(!session.has_key?("current_user_email"))
			flash[:invaliduser] = "You must be logged in to access this section"
			redirect_to "/login"
		end
	end
	end

end
