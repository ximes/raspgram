class Whitelist < ActiveRecord::Base
	scope :active, -> { where(active: true) }

	def self.import(telegram_contact)
		contact = Whitelist.find_or_initialize_by(:user_id => telegram_contact.user_id)
		contact.name = "#{telegram_contact.first_name} #{telegram_contact.last_name}"
		contact.phone_no = telegram_contact.phone_number if telegram_contact.phone_number
		begin 
			contact.save!
			true
		rescue 
			Rails.logger.debug contact.errors
			false
		end
	end
end
