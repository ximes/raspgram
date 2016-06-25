require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'capybara/poltergeist'

module Tricks::RefuseTrick
	module Definition
		def self.definition
			Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Next Refuse Collection', callback_data: 'refuse') if Refuse::callable?
		end
	end
	module CallbackQuery
		def self.init(context)
	        if context.message.data == 'refuse'
	          	response = Refuse::next
	          	Rails.logger.debug response.inspect

	          	if response.present?
	          		message = response
	          	else
	          		message = "An error occurred"
	          	end
	          	context.send_message(text: message, chat_id: context.message.message.chat.id)
	        end
  		end
	end
	class Scheduler
		def initialize
			response = Refuse::next
			Whitelist.active.each do |user|
		    	@token = Rails.application.secrets[:token]
    			@client = Telegram::Bot::Client.new(@token)
				@client.api.send_message(text: response, chat_id: user.user_id)
			end
		end
	end
end