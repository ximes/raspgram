class Scraper::Definition < ActiveRecord::Base
	self.table_name = :scraper_definitions

	has_many :list_rules, -> { where(ruleable_type: 'List') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_list
	has_many :detail_rules, -> { where(ruleable_type: 'Detail') }, class_name: "Scraper::Rule", foreign_key: :ruleable_id, before_add: :set_as_detail

	private 
	def set_as_list(rule)
		rule.ruleable_type = 'List'
	end
	def set_as_detail(rule)
		rule.ruleable_type = 'Detail'
	end
end