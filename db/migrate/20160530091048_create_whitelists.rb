class CreateWhitelists < ActiveRecord::Migration
  def up
  	#add the refuse trick to db
  	Trick.create(name: 'Whitelist', class_name: "whitelist", active: true, core: true)

    create_table :whitelists do |t|
  		t.string :name
		t.integer :user_id
		t.boolean :active
		t.string :phone_no

		t.timestamps null: false
    end
  end
  def down
  	#removerefuse trick from db
  	Trick.find_by(class_name: 'whitelist').destroy

    drop_table :whitelists
  end
end
