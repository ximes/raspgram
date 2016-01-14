module Parser
	class HueLights < Matcher
		attr_accessor :light_client, :command, :light, :group, :option, :hue_client_action

		def initialize
			@word = "hue"
		end
		def help
			"[list] [light name | group name] [color] [brightness]"
		end
		def man
			"Examples: hue list | hue on | hue off | hue all off | hue [Group name] [status] | hue [Lamp number] [status], where [status] is a value from the list [dim, cold, warm, bright, pink, red, blue, orange, purple, green, yellow, white]"
		end
		def parse(input, from)
			word, command, light, option, color, brightness = input.scan(/^#{@word}|\s(\b[a-z0-9]+\b)+/i).flatten
			
			@hue_client_action = "lights"

			case command
				when /list/i
					@hue_client_action = "list"
				when /off/i
					@light = "all" 
					@option = "off"
				when /on/i
					@light = "all" 
					@option = "on"
				else
					@light = command 
					@option = light if light
					@brightness = brightness if brightness
					@color = color if color
			end
			super
		end
		def callback
			response = []

			begin
				@light_client = Hue::Client.new
			rescue Exception => e
				return Telegram.msg e.to_s, @from
			end

			if @light_client
				case @hue_client_action
					when "list"
						if @light_client.lights.any?
							response << "Lights:"
							response << (@light_client.lights.map.each_with_index{|l, i| "#{i+1}.#{l.name}"}.join(","))
							response << ". "
						end

						if @light_client.groups.any?
							response << "Groups:"
							response << (@light_client.groups.map(&:name).join(","))
							response << ". "
						end
					else
						
						affected_lights = []

						case @light
							when /all/i
							 	affected_lights = @light_client.lights
							when /^[\d]+/i
								affected_lights = @light_client.lights.select{|l| l.id == @light}
							else
								affected_lights = @light_client.groups.select{|g| g.name.downcase == @light.downcase}.map(&:lights).flatten
						end

						conditions = {}

					    #HUE_RANGE = 0..65535
					    #SATURATION_RANGE = 0..255
					    #BRIGHTNESS_RANGE = 0..255
					    #COLOR_TEMPERATURE_RANGE = 153..500

						case @option
							when /on/i
								conditions[:on] = true
							when /off/i
								conditions[:on] = false
							when /dim/i
								conditions[:on] = true
								conditions[:brightness] = 20
								conditions[:saturation] = 155
							when /cold/i
								conditions[:on] = true
								conditions[:color_temperature] = 155
							when /warm/i
								conditions[:on] = true
								conditions[:color_temperature] = 500
							when /bright/i
								conditions[:on] = true
								conditions[:brightness] = 255
							when /red/i
								conditions[:hue] = 9550
								conditions[:on] = true
								conditions[:saturation] = 255
							when /pink/i
								conditions[:hue] = 55600
								conditions[:on] = true
								conditions[:saturation] = 255
							when /blue/i
								conditions[:hue] = 45000
								conditions[:on] = true
								conditions[:saturation] = 255
							when /orange/i
								conditions[:hue] = 16500
								conditions[:on] = true
								conditions[:saturation] = 255
							when /purple/i
								conditions[:hue] = 51850
								conditions[:on] = true
								conditions[:saturation] = 255
							when /green/i
								conditions[:hue] = 25600
								conditions[:on] = true
								conditions[:saturation] = 255
							when /yellow/i
								conditions[:hue] = 22000
								conditions[:on] = true
								conditions[:saturation] = 255
							when /white|clear/i
								conditions[:hue] = 35000
								conditions[:on] = true
								conditions[:saturation] = 255
						end

						if affected_lights.any?
							
							

							affected_lights.each{|l| 
								l.set_state(conditions)
							} if conditions.any?

							@light_client.lights.map.each_with_index do |l, index| 
								response << "Status of lights: #{affected_lights.map(&:name)} changed"
							end
						end
				end
			end
			@response = response.join("")
			super
		end
	end
end