Raspgram::Api.controllers :api do
  
  get :index, :map => '/', :provides => [:js] do
    content_type :json

    @client = Client::connect

    if params[:msg]
    	msg = params[:msg]
    end
    if params[:userid]
    	user_id = params[:userid]
    end
    
    response = {}
    
    if msg and user_id
    	Message.new()
    	Response.new()
    	response.store(:received, true)
	end

    response.to_json
  end
end
