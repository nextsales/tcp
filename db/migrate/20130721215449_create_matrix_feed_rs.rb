class CreateMatrixFeedRs < ActiveRecord::Migration
  def change
    create_table :matrix_feed_rs do |t|
      t.integer :matrix_id
      t.integer :feed_id

      t.timestamps
    end
  end
end
