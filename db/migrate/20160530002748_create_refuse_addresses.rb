class CreateRefuseAddresses < ActiveRecord::Migration
  def up
  	#add the refuse trick to db
  	Trick.create(name: 'Refuse (Bristol)', class_name: "refuse", active: false)

    create_table :refuse_addresses do |t|
      t.string :name
      t.string :house_no
      t.string :postcode
      t.boolean :active

      t.timestamps null: false
    end

  end
  def down
  	#removerefuse trick from db
  	Trick.find_by(class_name: 'refuse').destroy

    drop_table :refuse_addresses
  end
end
