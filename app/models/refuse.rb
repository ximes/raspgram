class Refuse < Trick
	def self.next
		collection_days = []
        active_address = RefuseAddress.active.try(:first)

        if active_address.present?
          	begin 
                Scraper::Definition.init
                Capybara.app_host = "https://www2.bristol.gov.uk"
                Capybara.visit('https://www2.bristol.gov.uk/forms/collection-day-finder')
                Capybara.find('#edit-house-number').set(active_address.house_no)
                Capybara.find('#edit-postcode').set(active_address.postcode)
                Capybara.find('.find-address').click
                Capybara.find('#edit-find-address-select').find(:xpath, 'option[2]').select_option
                Capybara.find('.button-next').click
                Capybara.find('#edit-submit').click
                Capybara.page.all('.collection-rounds tr').drop(1).each do |tr|
                    res = tr.all('td').map(&:text).reject(&:blank?)
                    collection_days << (res.first(2).join(": ") + ", next: " + res.drop(2).join(","))
                end
                response = "Next collection days for #{active_address.name}: #{collection_days.compact.join(". ")}"

       		rescue Exception => e
       			Rails.logger.debug e
       			response = e
        	end
        else
            response = "No active address found"
        end
        response
	end
end