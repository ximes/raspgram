class AddLightTrick < ActiveRecord::Migration
	def up
		#add the Lights trick to db
		Trick.create(name: 'Lights', class_name: "Light", active: false)
	end
	def down
		#remove Lights trick from db
		Trick.find_by(class_name: 'Light').destroy
	end
end
