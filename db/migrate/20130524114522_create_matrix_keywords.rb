class CreateMatrixKeywords < ActiveRecord::Migration
  def change
    create_table :matrix_keywords do |t|
      t.integer :matrix_id
      t.string :name

      t.timestamps
    end
  end
end
