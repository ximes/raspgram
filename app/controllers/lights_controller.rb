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

  def update
    if check_connection

      light = @light_client.lights.select{|l| l.id == light_update_params[:id]}.first

      if light      
        if light_update_params[:on]
          light.on!
        else
          light.off!
        end

        if light_update_params[:hue].to_i != light.hue
          light.set_state({"saturation"=>255, "hue"=>light_update_params[:hue].to_i}, 10)
        else
          light.set_state(light_update_params.each{|k,v| light_update_params[k] = v.to_i}, 10)
        end
      end
  

    end
    render :nothing => true
  end

  private
  def check_connection
    begin 
      @light_client = Hue::Client.new
    rescue
      false
    end
  end

  def light_update_params
    params.require(:light)
  end
end
