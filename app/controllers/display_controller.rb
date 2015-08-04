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

end
