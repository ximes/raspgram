module Gestures::Refuse
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Next Refuse Collection', callback_data: 'refuse')
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'refuse'
	          context.send_message(text: "refuse", chat_id: context.message.message.chat.id)
	        end
  		end
	end
end
