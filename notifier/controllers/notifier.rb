require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'capybara/poltergeist'
require 'httparty'
require_relative '../../models/parser/matchers/matcher'
require_relative '../../models/parser/matchers/refuse/refuse'


Raspgram::Notifier.controllers :notifier do
  
  get :index, :map => '/' do

	refuse = Parser::Refuse.new

	@refuse = refuse.get_results.compact

	transport_service = Transport.new(settings.bristol_transports_api_key)

	@transports = []
	@transports << { to: "Tc Office", calls: transport_service.get_calls(settings.stop_ids["to_tc"]), warnings: []}
	@transports << { to: "Temple Meads", calls: transport_service.get_calls(settings.stop_ids["to_temple_meads"]), warnings: [] }

	#transport_tc.get_warnings(settings.tc_stop_id)

	weather = Weather.new(settings.metoffice_api_key)
	
	@weather_warnings = weather.get_warnings(settings.metoffice_location_id)

	@weather_forecasts = weather.get_forecast(settings.metoffice_location_id)

    render 'index'
  end
  get :internal, :map => '/internal.html' do
    render 'internal'
  end
end