require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'capybara/poltergeist'

module Parser
	class Refuse < Matcher

		include Capybara::DSL

		def initialize
			@word = "refuse"
		end
		def callback

			Response.new(Telegram.msg "Next collection days:", @from).execute!

			@response = get_results.compact.join(". ")

			super
		end

		def get_results
			response = []

			begin
				Capybara.app_host = "https://www2.bristol.gov.uk"
				Capybara.run_server = false
				Capybara.current_driver = :poltergeist
				Capybara.javascript_driver = :poltergeist

				visit('https://www2.bristol.gov.uk/forms/collection-day-finder')

				find('#edit-house-number').set("81")
				find('#edit-postcode').set("bs66aw")
				find('.find-address').click

				find('#edit-find-address-select').find(:xpath, 'option[2]').select_option

				find('.button-next').click

				find('#edit-submit').click

				page.all('.collection-rounds tr').drop(1).each do |tr|
					res = tr.all('td').map(&:text).reject(&:blank?)
					response << (res.first(2).join(": ") + ", next: " + res.drop(2).join(","))
				end
			rescue Exception => e
				response = []
			end
			response
		end
	end
end