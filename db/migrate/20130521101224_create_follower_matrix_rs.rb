class CreateFollowerMatrixRs < ActiveRecord::Migration
  def change
    create_table :follower_matrix_rs do |t|
      t.integer :user_id
      t.integer :matrix_id

      t.timestamps
    end
  end
end
