class AddDiceTrick < ActiveRecord::Migration
	def up
		#add the dice trick to db
		Trick.create(name: 'Dice', class_name: "dice", active: true, core: true)
	end
	def down
		#remove dice trick from db
		Trick.find_by(class_name: 'dice').destroy
	end
end
