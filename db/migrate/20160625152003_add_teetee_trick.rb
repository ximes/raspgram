class AddTeeteeTrick < ActiveRecord::Migration
	def up
		#add the Teetee trick to db
		Trick.create(name: 'Tee Tee', class_name: "Teetee", active: false)
	end
	def down
		#remove Teetee trick from db
		Trick.find_by(class_name: 'Teetee').destroy
	end
end
