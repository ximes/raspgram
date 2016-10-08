class LightsController < ApplicationController
  before_filter :set_light_client

  skip_before_action :verify_authenticity_token, only: [:update]

  def index    
  end

  def create
      redirect_to lights_path
  end

  def update
    if @light_client

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

  def set_light_client
    @light_client = Light.check_connection
  end

  private

  def light_update_params
    params.require(:light)
  end
end
