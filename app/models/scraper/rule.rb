class Scraper::Rule < ActiveRecord::Base
	self.table_name = :scraper_rules

	belongs_to :definition , class_name: 'Scraper::Definition', foreign_key: :ruleable_id
	
	scope :for_list, ->{ where(ruleable_type: 'List')}
	scope :for_detail, ->{ where(ruleable_type: 'Detail')}

	def list?
		ruleable_type == 'List'
	end
	def detail?
		ruleable_type == 'Detail'
	end
end