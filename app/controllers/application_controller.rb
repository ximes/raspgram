class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  before_filter :access_by_token
    
  ACCESS_TOKEN = 'kugayashi'

  protected

  def layout_by_resource
 	if devise_controller? && resource_name == :user && action_name == "new"
      "registration"
    else
      "application"
    end
  end

  def access_by_token
    unless params[:token] and params[:token] == ACCESS_TOKEN
      #authenticate_user!
    end
  end
end
