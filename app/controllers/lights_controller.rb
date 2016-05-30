class LightsController < ApplicationController
	before_action :authenticate_user!

  def index
    check_connection
  end

  def create
      unless check_connection
        Light.setup_connection
      end
      redirect_to lights_path
  end

  private
  def check_connection
    begin 
      @light_client = Hue::Client.new
    rescue
      false
    end
  end
end
