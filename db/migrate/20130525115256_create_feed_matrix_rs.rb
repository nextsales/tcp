class CreateFeedMatrixRs < ActiveRecord::Migration
  def change
    create_table :feed_matrix_rs do |t|
      t.integer :feed_id
      t.integer :matrix_id

      t.timestamps
    end
  end
end
