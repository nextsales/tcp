class CreateMediaMatrixRs < ActiveRecord::Migration
  def change
    create_table :media_matrix_rs do |t|
      t.integer :matrix_id
      t.integer :media_site_id

      t.timestamps
    end
  end
end
