class CreateScraperRules < ActiveRecord::Migration
  def change
    create_table :scraper_rules do |t|
    t.text :matcher_code
    t.text :action_code
    t.integer :ruleable_id
    t.string :ruleable_type

    t.timestamps null: false
  end

    add_index :scraper_rules, [:ruleable_type, :ruleable_id]
  end
end
