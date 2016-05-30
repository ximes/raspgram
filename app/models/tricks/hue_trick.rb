module Tricks::HueTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Lights', callback_data: 'hue')if Hue::callable?
		end
	end
	module CallbackQuery
		def self.init(context)
		    if context.message.data == 'hue'
		      kb = [
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: '2', callback_data: 'hue_number_intensity_color'),
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')
		      ]
		      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
		      
		      context.send_message(text: 'Which one?', reply_markup: markup, chat_id: context.message.message.chat.id, force_reply: true)
		    end
  		end
	end
end