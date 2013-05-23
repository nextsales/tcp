class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :photo_url
      t.integer :company_id
      t.string :url
      t.integer :shares
      t.integer :likes
      t.integer :matrix_id
      t.datetime :origin_created_time
      t.text :content
      t.string :feed_type

      t.timestamps
    end
  end
end
