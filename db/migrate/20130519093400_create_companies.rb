class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :country
      t.string :email
      t.string :phone
      t.string :postcode
      t.string :website
      t.string :facebook_id
      t.string :linkedin_id
      t.string :twitter_id

      t.timestamps
    end
    add_index :companies, :name, :unique => true
    add_index(:companies, :linkedin_id, :unique => true)
    add_index(:companies, :facebook_id, :unique => true)
    add_index(:companies, :twitter_id, :unique => true)
  end
end
