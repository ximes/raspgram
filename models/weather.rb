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
        forecasts = Nokogiri.XML(forecast_request.response.body).css("Period").select{|response|
          response[:value] == Date.today.strftime("%Y-%m-%dZ")
        }
      end
      forecasts.map{|f| 
        8.times.map.each_with_index{|time_range, index|
          children = f.children.select{|v| v.content.to_i == 180*index}
          if children.any?
            child = children.first
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
              value: (180*index)..(180*(index+1))
            }
          else
            {
              type: nil,
              value: (180*index)..(180*(index+1))
            }
          end
        }
      }.first

    rescue Exception => e
      []
    end
      
  end
end
