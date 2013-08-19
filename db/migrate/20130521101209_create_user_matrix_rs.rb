class CreateUserMatrixRs < ActiveRecord::Migration
  def change
    create_table :user_matrix_rs do |t|
      t.integer :user_id
      t.integer :matrix_id

      t.timestamps
    end
    add_index(:user_matrix_rs, :user_id)
    add_index(:user_matrix_rs, :matrix_id)
  end
end
