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
    	message = Message.new(:content => msg, :to => user_id)

        response.store(:received, true)

        if message and message.parse?
            response.store(:response, message.parse!)
        end
    	
	end

    response.to_json
  end
end
