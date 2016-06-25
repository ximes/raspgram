module Tricks::StatusTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Status', callback_data: 'status')
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'status'
	          context.send_message(text: "All Ok", chat_id: context.message.message.chat.id)
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