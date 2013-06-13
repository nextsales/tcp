class CreateLinkedinUpdates < ActiveRecord::Migration
  def change
    create_table :linkedin_updates do |t|
      t.integer :linkedin_company_id
      t.string :update_key
      t.string :update_type
      t.text :raw_data

      t.timestamps
    end
    add_index :linkedin_updates, :update_key, :unique => true
  end
end
