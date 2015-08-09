Raspgram::Api.controllers :api do
  
  get :index, :map => '/', :provides => [:js] do
    content_type :json

    @client = Client::connect

    if params[:msg]
    	msg = params[:msg]
    end
    if params[:user]
    	user = params[:user]
    end
    
    response = {}
    
    if msg and user
    	message = Message.new(:content => msg, :to => user)

        response.store(:received, true)

        if message and message.has_valid_response?
            message.respond
            response.store(:response, message.response)
        end
    	
	end

    response.to_json
  end
end
