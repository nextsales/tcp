class CreateCompanyMatrixRs < ActiveRecord::Migration
  def change
    create_table :company_matrix_rs do |t|
      t.integer :company_id
      t.integer :matrix_id
      t.boolean :is_approved

      t.timestamps
    end
  end
end
