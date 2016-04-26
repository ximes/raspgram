module Gestures::Dice
	module Internal
		def self.init(context)
			lambda{
			    if context.message.data == 'dice'
			      kb = [
			        Telegram::Bot::Types::InlineKeyboardButton.new(text: '2', callback_data: 'dice_2'),
			        Telegram::Bot::Types::InlineKeyboardButton.new(text: '6', callback_data: 'dice_6'),
			        Telegram::Bot::Types::InlineKeyboardButton.new(text: '20', callback_data: 'dice_20'),
			        Telegram::Bot::Types::InlineKeyboardButton.new(text: '100', callback_data: 'dice_100'),
			        Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')
			      ]
			      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
			      context.send_message(text: '', reply_markup: markup)
			    end

		        if context.message.data == 'dice_2'
		          context.send_message(text: Dice.throw(2))
		        end
		        if context.message.data == 'dice_6'
		          context.send_message(text: Dice.throw(6))
		        end
		        if context.message.data == 'dice_20'
		          context.send_message(text: Dice.throw(20))
		        end
		        if context.message.data == 'dice_100'
		          context.send_message(text: Dice.throw(100))
		        end
		        if context.message.data == 'status'
		          context.send_message(text: "All Ok")
		        end
		        if context.message.data == 'refuse'
		          context.send_message(text: "refuse")
		        end
		        if context.message.data == 'transport'
		          context.send_message(text: "ok")
		        end
			}
		end
	end
	class Dice
		def self.throw(val)
			rand(val) + 1
		end
	end
end
