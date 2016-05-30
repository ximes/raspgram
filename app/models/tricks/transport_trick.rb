module Tricks::TransportTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Transport Check', callback_data: 'transport') if Transport::callable?
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'transport'
	          context.send_message(text: "ok", chat_id: context.message.message.chat.id)
	        end
  		end
	end
end