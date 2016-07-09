require 'open3'

module Tricks::StatusTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Status', callback_data: 'status')
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'status'
				begin 
					str = Rails.application.secrets['temperature_check_command']
					temp, stdeerr, status = Open3.capture3(str)
				rescue
				end

				begin 	          	
	          		str = Rails.application.secrets['free_space_check_command']
					space, stdeerr, status = Open3.capture3(str)
				rescue
				end

	          	context.send_message(text: "All Ok.\r\n#{temp.capitalize}Free space: #{space}", chat_id: context.message.message.chat.id)
	        end
  		end
	end
	class Scheduler
		def initialize
			response = '.'
			Whitelist.active.each do |user|
		    	@token = Rails.application.secrets[:token]
    			@client = Telegram::Bot::Client.new(@token)
				@client.api.send_message(text: response, chat_id: user.user_id)
			end
		end
	end
end