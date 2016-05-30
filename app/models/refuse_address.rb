class RefuseAddress < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :house_no, presence: true
    validates :postcode, presence: true

    after_save :unique_active

    scope :active, -> { where(active: true) }

    private
    def unique_active
    	if self.active?
    		RefuseAddress.where.not(id: self).update_all(active: false)
    	end
    end
end
