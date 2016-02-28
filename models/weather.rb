class Weather
  attr_accessor :api_key

  include HTTParty

  base_uri 'http://datapoint.metoffice.gov.uk'

  def initialize(api_key = nil)
    @api_key = api_key
  end

  def get_warnings(location_id)
    begin
      warning_request = self.class.get("/public/data/txt/wxobs/ukextremes/xml/latest", :query => {
      :key => @api_key,
      })
      if warning_request.response.body
        warnings = Nokogiri.XML(warning_request.response.body).css("Extreme").select{|response|
          response[:locId] == ("%05d" % location_id)
        }
      end

      warnings.map{|w| {
        type: w["type"], 
        unit: w["uom"], 
        value: w.content
      }}
    rescue Exception => e
       []
    end
      

  end
  def get_forecast(location_id)
    begin
      forecast_request = self.class.get("/public/data/val/wxfcs/all/xml/#{location_id}", :query => {
      :key => @api_key,
      :res => '3hourly'})

      if forecast_request.response.body
        forecasts = Nokogiri.XML(forecast_request.response.body).css("Rep").reject{ |response|
          (response.parent[:value] == Date.today.strftime("%Y-%m-%dZ") and (Date.today.beginning_of_day + (response.content.to_i).minutes) <= Time.now) or (!response.content.to_i.between?(300, 1200))
        }
      end

      forecasts.map{|child| 
        {
          f: child["F"], #Feels Like Temperature, units="C"
          g: child["G"], #Wind Gust, units="mph"
          h: child["H"], #Screen Relative Humidity , units="%">
          t: child["T"], #Temperature, units="C"
          v: child["V"], #Visibility
          d: child["D"], #Wind Direction, units="compass"
          s: child["S"], #Wind Speed, units="mph"
          u: child["U"], #Max UV Index
          type: child["W"].to_i, #Weather Type
          p: child["Pp"], #Precipitation Probability, units="%"
          value: child.content.to_i..(child.content.to_i + 180), #(180*index)..(180*(index+1)),
          date: child.parent[:value]
        }
      }.flatten

    rescue Exception => e
      []
    end
      
  end
end
