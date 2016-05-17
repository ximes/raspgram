module Gestures::Hue
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Lights', callback_data: 'hue')
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'hue'
	          context.send_message(text: "hue", chat_id: context.message.message.chat.id)
	        end
  		end
	end
end
