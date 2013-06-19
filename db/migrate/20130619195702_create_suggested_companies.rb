class CreateSuggestedCompanies < ActiveRecord::Migration
  def change
    create_table :suggested_companies do |t|
      t.string :name
      t.string :country
      t.string :linkedin_id
      t.string :logo_url
      t.text :raw_data
      t.integer :rank
      t.integer :user_id

      t.timestamps
    end
  end
end
