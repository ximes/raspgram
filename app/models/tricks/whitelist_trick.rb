module Tricks::WhitelistTrick
	module Definition
		def self.definition
			nil
		end
	end
	module PreFilter
		def self.init(context)
			matching_users = Whitelist.find_by(user_id: context.message.from.id).active
	        if matching_users
          		context.allowed = true
	        else
          		context.send_message(text: "This user is not allowed")
	        end
  		end
	end
	module CallbackMessages
		def self.init(context)
			if context.message.contact.present?
				if Whitelist.import(context.message.contact)
					context.send_message(text: "New User #{context.message.contact.first_name} #{context.message.contact.last_name} has been whitelisted")
				else
					context.send_message(text: "Sorry, user #{context.message.contact.first_name} #{context.message.contact.last_name} hasn't been added")
				end         		
	        end
  		end
	end
end