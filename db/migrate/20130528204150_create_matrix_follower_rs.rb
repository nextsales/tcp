class CreateMatrixFollowerRs < ActiveRecord::Migration
  def change
    create_table :matrix_follower_rs do |t|
      t.integer :matrix_id
      t.integer :follower_id

      t.timestamps
    end
  end
end
