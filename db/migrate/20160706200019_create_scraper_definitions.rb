class CreateScraperDefinitions < ActiveRecord::Migration
  def change
    create_table :scraper_definitions do |t|
  		t.string :app_url
		t.string :list_url
		t.string :name
		t.boolean :active
		t.text :schedule_range

		t.timestamps null: false
    end
  end
end
