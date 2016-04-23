class CreateTricks < ActiveRecord::Migration
  def change
    create_table :tricks do |t|
      t.string :name
      t.boolean :core
      t.string :class_name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
