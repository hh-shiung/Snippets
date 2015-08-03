class DisplayController < ApplicationController

	def showIndex
		render template: 'landing/index'
	end

	def showLogin
		render template: 'snippets/login'
	end

	def showLock
		render template: 'snippets/lock_screen'
	end
	
end
