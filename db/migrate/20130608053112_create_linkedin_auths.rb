class CreateLinkedinAuths < ActiveRecord::Migration
  def change
    create_table :linkedin_auths do |t|
      t.string :email
      t.string :first_name
      t.string :full_name
      t.string :headline
      t.string :industry
      t.string :last_name
      t.string :location
      t.string :phone
      t.string :photo
      t.string :raw_auth
      t.string :secret
      t.string :token
      t.string :uid

      t.timestamps
    end
  end
end
