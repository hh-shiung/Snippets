class DisplayController < ApplicationController

	def showIndex
		render template: 'landing/index'
	end

end
