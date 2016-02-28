class Transport
  attr_accessor :api_key

  include HTTParty

  base_uri 'https://bristol.api.urbanthings.io'

  def initialize(api_key = nil)
    @api_key = api_key
  end

  def get_warnings(stop_id)
   

  end
  def calls_to_tc(stop_id)
    begin
      transport_request = self.class.get("/api/2-0/rti/stopboard", :query => {
      :apikey => @api_key,
      :stopID => stop_id
      }, :headers => {
        'Accept' => 'application/xml' 
      })

      if transport_request.response.body
        calls = Nokogiri.XML(transport_request.response.body).css("StopBoardRow").select{|d|
          d.css("MainLabel").children.first.content == "Cribbs Causeway"
        }
      end

      calls.map{|child| 
        {
          line_no: child.css("IDLabel").children.first.content,
          next_time: child.css("TimeLabel").children.first.content,
        }
      }.flatten

    rescue Exception => e
      []
    end
      
  end
end
