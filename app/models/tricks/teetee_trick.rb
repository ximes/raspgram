module Tricks::TeeteeTrick
    module Definition
        def self.definition
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Teetee', callback_data: 'teetee_current') if Teetee.callable?
        end
    end
    module CallbackQuery
        def self.init(context)
            if context.message.data == 'teetee_current'
            	response = Teetee.current_design

				file = Faraday::UploadIO.new(response[:file], 'image/png')
				context.send_photo(caption: response[:text], chat_id: context.message.message.chat.id, photo: file)
            end
        end
    end
	class Scheduler

		def initialize
			return unless Teetee.callable?
			
			response = Teetee.current_design
			if response
				Whitelist.active.each do |user|
			    	@token = Rails.application.secrets[:token]
	    			@client = Telegram::Bot::Client.new(@token)
					file = Faraday::UploadIO.new(response[:file], 'image/png')
					@client.api.send_photo(caption: response[:text], chat_id: user.user_id, photo: file)
				end
			end
		end
	end
end