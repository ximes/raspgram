module Gestures::Dice
	
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dice', callback_data: 'dice')
		end
	end
	module CallbackQuery
		def self.init(context)
		    if context.message.data == 'dice'
		      kb = [
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: '2', callback_data: 'dice_2'),
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: '6', callback_data: 'dice_6'),
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: '20', callback_data: 'dice_20'),
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: '100', callback_data: 'dice_100'),
		        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')
		      ]
		      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
		      
		      context.send_message(text: 'What size?', reply_markup: markup, chat_id: context.message.message.chat.id, force_reply: true)
		    end

	        if context.message.data == 'dice_2'
	          context.send_message(text: Dice.throw(2), chat_id: context.message.message.chat.id)
	        end
	        if context.message.data == 'dice_6'
	          context.send_message(text: Dice.throw(6), chat_id: context.message.message.chat.id)
	        end
	        if context.message.data == 'dice_20'
	          context.send_message(text: Dice.throw(20), chat_id: context.message.message.chat.id)
	        end
	        if context.message.data == 'dice_100'
	          context.send_message(text: Dice.throw(100), chat_id: context.message.message.chat.id)
	        end
		end
	end
	class Dice
		def self.throw(val)
			"Yeah, here's your result: #{(rand(val) + 1)}"
		end
	end
end
