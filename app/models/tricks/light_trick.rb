module Tricks::LightTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Lights', callback_data: 'light') if Light::callable?
		end
	end
	module CallbackQuery
		def self.init(context)
		    
		    if context.message.data == 'light_setup'
				begin 
					@setup = Light.setup_connection
					@light_client = Hue::Client.new
					context.send_message(text: 'Connection set up succesful', chat_id: context.message.message.chat.id)
				rescue
					Rails.logger.debug @setup.inspect
					context.send_message(text: 'Something went wrong', chat_id: context.message.message.chat.id)
				end
		    end

			begin 
				@light_client = Hue::Client.new
			rescue
				kb = [
					Telegram::Bot::Types::InlineKeyboardButton.new(text: 'I pressed the button on the Bridge', callback_data: 'light_setup')
				]
				markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
				context.send_message(text: 'Hue Bridge not set up yet. Please press the button on the Hub and try again within 30 seconds', chat_id: context.message.message.chat.id, reply_markup: markup)

				return
			end

		    if context.message.data == 'light'
				kb = []
				kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'All', callback_data: 'light_which_all')
				@light_client.lights.each do |light|
					kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "#{light.name}", callback_data: "light_which_#{light.id}")
				end

				kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')
				markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)

				context.send_message(text: 'Which one?', reply_markup: markup, chat_id: context.message.message.chat.id)
		    end

		    if light_match = /^light_which_([a-zA-Z0-9]*)$/.match(context.message.data).try(:captures).try(:last)
		    	affected_lights = []
                
				kb = []
				[
					"on",
				 	"off",
					"dim",
					"bright",
					"cold",
					"warm",
				#	"red",
				#	"yellow",
					"white",
				#	"random",
				#	"green",
				#	"blue",
				#	"pink",
				#	"purple",
				# 	"orange"
			 	].each do |key|
					kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: key.capitalize, callback_data: "light_which_#{light_match}_#{key}")
				end
				kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')

				markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)

				context.send_message(text: 'How should I set it up?', reply_markup: markup, chat_id: context.message.message.chat.id)
		    end

		    if light_match = /^light_which_([a-zA-Z0-9]*)_([a-zA-Z0-9]*)$/.match(context.message.data)

		    	affected_lights = []
                case light_match[1]
                    when /all/
                         affected_lights = @light_client.lights
                    when /^[\d]+/
                        affected_lights = @light_client.lights.select{|l| l.id == light_match[1]}
                    else
                        affected_lights = @light_client.groups.select{|g| g.name == light_match[1]}.map(&:lights).flatten
                end

	            case light_match[2]
	                when /on/
	                    hue_action = :on!
	                when /off/
	                    hue_action = :off!
	                when /dim/
	                    hue_action = :on!
	                    hue_brightness = 20
	                when /bright/
	                    hue_action = :on!
	                    hue_brightness = 255
	                when /cold/
	                    hue_action = :on!
	                    hue_color_temperature = 20
	                when /warm/
	                    hue_action = :on!
	                    hue_color_temperature = 99
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
	                when /random/
	                    hue_color_temperature = rand(20)
	                    hue_brightness = rand(100)
	                    hue_color = rand(64000)
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
	            end
	            context.send_message(text: 'Done', chat_id: context.message.message.chat.id)
		    end
  		end
	end
end