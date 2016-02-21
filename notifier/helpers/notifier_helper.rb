# Helper methods defined here can be accessed in any controller or view in the application

module Raspgram
  class Notifier
    module NotifierHelper
    	def weather_time_range(time_range)
    		"#{(Time.now.beginning_of_day + time_range.first.minutes).strftime('%H')}-#{(Time.now.beginning_of_day + time_range.last.minutes).strftime('%H')}"
    	end
    	def weather_image(type)
	    	img = case type
				when 0
					["Clear night", "/images/icon_weather_w0.png"]
				when 1
					["Sunny day", "/images/icon_weather_w1.png"]
				when 2
					["Partly cloudy (night)", "/images/icon_weather_w2.png"]
				when 3
					["Partly cloudy (day)", "/images/icon_weather_w3.png"]
				when 4
					["Not used", "/images/icon_weather_w4.png"]
				when 5
					["Mist", "/images/icon_weather_w5.png"]
				when 6
					["Fog", "/images/icon_weather_w6.png"]
				when 7
					["Cloudy", "/images/icon_weather_w7.png"]
				when 8
					["Overcast", "/images/icon_weather_w8.png"]
				when 9
					["Light rain shower (night)", "/images/icon_weather_w9.png"]
				when 10
					["Light rain shower (day)", "/images/icon_weather_w10_1.png"]
				when 11
					["Drizzle", "/images/icon_weather_w11.png"]
				when 12
					["Light rain", "/images/icon_weather_w12.png"]
				when 13
					["Heavy rain shower (night)", "/images/icon_weather_w13.png"]
				when 14
					["Heavy rain shower (day)", "/images/icon_weather_w14.png"]
				when 15
					["Heavy rain", "/images/icon_weather_w15.png"]
				when 16
					["Sleet shower (night)", "/images/icon_weather_w16.png"]
				when 17
					["Sleet shower (day)", "/images/icon_weather_w17.png"]
				when 18
					["Sleet", "/images/icon_weather_w18.png"]
				when 19
					["Hail shower (night)", "/images/icon_weather_w19.png"]
				when 20
					["Hail shower (day)", "/images/icon_weather_w20.png"]
				when 21
					["Hail", "/images/icon_weather_w21.png"]
				when 22
					["Light snow shower (night)", "/images/icon_weather_w22.png"]
				when 23
					["Light snow shower (day)", "/images/icon_weather_w23.png"]
				when 24
					["Light snow", "/images/icon_weather_w24.png"]
				when 25
					["Heavy snow shower (night)", "/images/icon_weather_w25.png"]
				when 26
					["Heavy snow shower (day)", "/images/icon_weather_w26.png"]
				when 27
					["Heavy snow", "/images/icon_weather_w27.png"]
				when 28
					["Thunder shower (night)", "/images/icon_weather_w28.png"]
				when 29
					["Thunder shower (day)", "/images/icon_weather_w29.png"]
				when 30
					["Thunder", "/images/icon_weather_w30.png"]
				else
					["NA Not available", "/images/icon_weather_w99.png"]
			end
			"<img class='icon icon-weather' src='#{img.second}' alt='#{img.first}' />"
		end
    end

    helpers NotifierHelper
  end
end
