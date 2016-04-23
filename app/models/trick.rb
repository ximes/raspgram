class Trick < ActiveRecord::Base
	validates :name, presence: true

	scope :core, -> { where(core: true) }
	scope :active, -> { where(active: true) }
end
