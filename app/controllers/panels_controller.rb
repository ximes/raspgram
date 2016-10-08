class PanelsController < ApplicationController

	def show
		@light_client = Light.check_connection
		render 'show', layout: 'panel'
	end
end
