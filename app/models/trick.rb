class Trick < ActiveRecord::Base
	validates :name, presence: true

	scope :core, -> { where(core: true) }
	scope :active, -> { where(active: true) }

	def self.callable?
		Trick.where(class_name: self).active.count > 0
	end
end
