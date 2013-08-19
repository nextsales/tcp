class CreateUserCompanyRs < ActiveRecord::Migration
  def change
    create_table :user_company_rs do |t|
      t.integer :user_id
      t.integer :company_id

      t.timestamps
    end
    add_index(:user_company_rs, :user_id)
    add_index(:user_company_rs, :company_id)
  end
end
