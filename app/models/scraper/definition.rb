class Scraper::Definition < ActiveRecord::Base
	self.table_name = :scraper_definitions

	serialize :schedule_range, Array

	has_many :list_rules, -> { where(ruleable_type: 'List') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_list
	has_many :detail_rules, -> { where(ruleable_type: 'Detail') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_detail

	scope :active, -> { where(active: true) }

	accepts_nested_attributes_for :list_rules, reject_if: :all_blank, allow_destroy: true
	accepts_nested_attributes_for :detail_rules, reject_if: :all_blank, allow_destroy: true

	def self.init
		Capybara.register_driver :poltergeist do |app|
			driver = Capybara::Poltergeist::Driver.new(app, :js_errors => false, :debug => false, :phantomjs_options => ['--load-images=no', '--web-security=true'])
		end
	  	

		Capybara.run_server = false
		Capybara.current_driver = :poltergeist
		Capybara.javascript_driver = :poltergeist


		@token = Rails.application.secrets[:token]
		return Telegram::Bot::Client.new(@token)
	end

	def launch!
		@client = Scraper::Definition.init
		@response = ""
		begin
			list_rules.each do |rule|
				eval(rule.matcher_code, binding) if rule.matcher_code
				eval(rule.action_code, binding) if rule.action_code
			end
		rescue Exception => e
			
			Rails.logger.debug e.inspect
			Rails.logger.debug e.try(:message).inspect
			@response = e
		end
	end
	def self.schedule_range_options
		["12 AM"] + (1.upto(11).collect{ |n| "#{n} AM" }) + ["12 PM"] + (1.upto(11).collect{ |n| "#{n} PM"})
	end
	def self.launch_scheduled
		@client = Scraper::Definition.init
		active.select{|s| s.schedule_range.include?(Time.now.strftime("%l %p").strip)}.each do |scraper|
			scraper.launch!
		end
	end


	private 
	def set_as_list(rule)
		rule.ruleable_type = 'List'
	end
	def set_as_detail(rule)
		rule.ruleable_type = 'Detail'
	end
end