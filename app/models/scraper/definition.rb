class Scraper::Definition < ActiveRecord::Base
	self.table_name = :scraper_definitions

	serialize :schedule_range, Array

	has_many :list_rules, -> { where(ruleable_type: 'List') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_list
	has_many :detail_rules, -> { where(ruleable_type: 'Detail') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_detail

	def self.schedule_range_options
		["12 AM"] + (1.upto(11).collect{ |n| "#{n} AM" }) + ["12 PM"] + (1.upto(11).collect{ |n| "#{n} PM"})
	end
	private 
	def set_as_list(rule)
		rule.ruleable_type = 'List'
	end
	def set_as_detail(rule)
		rule.ruleable_type = 'Detail'
	end
end