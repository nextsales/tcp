class CreateInstantFeeds < ActiveRecord::Migration
  def change
    create_table :instant_feeds do |t|
      t.string :title
      t.string :photo_url
      t.string :url
      t.integer :shares
      t.integer :likes
      t.datetime :origin_created_time
      t.text :content
      t.string :feed_type

      t.timestamps
    end
  end
end
