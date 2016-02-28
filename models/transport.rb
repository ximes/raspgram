class Transport
  attr_accessor :api_key

  include HTTParty

  base_uri 'https://bristol.api.urbanthings.io'

  def initialize(api_key = nil)
    @api_key = api_key
  end

  def get_warnings(stop_id)
   

  end
  def get_calls(stop_id)
    begin
      transport_request = self.class.get("/api/2-0/rti/stopboard", :query => {
      :apikey => @api_key,
      :stopID => stop_id
      }, :headers => {
        'Accept' => 'application/xml' 
      })

      if transport_request.response.body
        calls = Nokogiri.XML(transport_request.response.body).css("StopBoardRow")
      end

      calls.map{|child| 
        {
          line_no: child.css("IDLabel").children.first.content,
          next_time: child.css("TimeLabel").children.first.content,
          destination: child.css("MainLabel").children.first.content
        }
      }.flatten

    rescue Exception => e
      []
    end
      
  end
end
