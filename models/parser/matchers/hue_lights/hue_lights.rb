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
			"Examples: hue list | hue on | hue off | hue all off | hue [Group name] [status] | hue [Lamp number] [status], where [status] is a value from the list [dim, color, cold, warm, bright, red, blue, orange, purple, green, yellow]"
		end
		def parse(input, from)
			word, command, light, option, color, brightness = input.scan(/^#{@word}|\s(\b[a-z0-9]+\b)+/i).flatten
			
			@hue_client_action = "lights"

			case command
				when /list/
					@hue_client_action = "list"
				when /off/
					@light = "all" 
					@option = "off"
				when /on/
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
							when /all/
							 	affected_lights = @light_client.lights
							when /^[\d]+/
								affected_lights = @light_client.lights.select{|l| l.id == @light}
							else
								affected_lights = @light_client.groups.select{|g| g.name == @light}.map(&:lights).flatten
						end

						case @option
							when /on/
								hue_action = :on!
							when /off/
								hue_action = :off!
							when /dim/
								hue_action = :on!
								hue_color_temperature = 20
								hue_brightness = 20
								hue_color = 40920
							when /color/
								hue_action = :on!
							when /cold/
								hue_action = :on!
							when /warm/
								hue_action = :on!
							when /bright/
								hue_action = :on!
							when /red/
								hue_action = :on!
							when /blue/
								hue_action = :on!
							when /orange/
								hue_action = :on!
							when /purple/
								hue_action = :on!
							when /green/
								hue_action = :on!
							when /yellow/
								hue_action = :on!
						end

						if affected_lights.any?

							affected_lights.each{|l| 
								l.send(hue_action.to_sym)
								l.brightness = hue_brightness if hue_brightness
								l.hue = hue_color if hue_color
								l.color_temperature = hue_color_temperature if hue_color_temperature
								} if hue_action.present?

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