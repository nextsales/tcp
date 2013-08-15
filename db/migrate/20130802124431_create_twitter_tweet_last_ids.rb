class CreateTwitterTweetLastIds < ActiveRecord::Migration
  def change
    create_table :twitter_tweet_last_ids do |t|
      t.integer :matrix_id
      t.integer :company_id
      t.integer :tweet_last_id, :limit => 8
      t.timestamps
    end
  end
end
