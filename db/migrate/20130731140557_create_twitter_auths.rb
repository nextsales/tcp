class CreateTwitterAuths < ActiveRecord::Migration
  def change
    create_table :twitter_auths do |t|
      t.string :origin_created_at
      t.string :description
      t.string :image
      t.string :location
      t.string :name
      t.string :nickname
      t.string :provider
      t.string :secret
      t.string :token
      t.string :uid
      t.integer :listed_count
      t.string :time_zone
      t.integer :followers_count
      t.integer :favourites_count
      t.integer :friends_count
      t.string :id_str
      t.integer :user_id
      t.string :lang

      t.timestamps
    end
  end
end
