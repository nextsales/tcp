class CreateSearchFeeds < ActiveRecord::Migration
  def change
    create_table :search_feeds do |t|
      t.string :feed_key
      t.string :feed_type
      t.datetime :origin_created_time
      t.text :raw_content

      t.timestamps
    end
    add_index(:search_feeds, :feed_key)
  end
end
