require 'capybara'
require 'capybara/dsl'
require 'capybara/mechanize'
require 'capybara/poltergeist'
require_relative '../../models/parser/matchers/matcher'
require_relative '../../models/parser/matchers/refuse/refuse'


Raspgram::Notifier.controllers :notifier do
  
  get :index, :map => '/' do

	response = []
	refuse = Parser::Refuse.new

	@refuse = refuse.get_results.compact

    render 'index'
  end
  get :internal, :map => '/internal.html' do
    render 'internal'
  end
end