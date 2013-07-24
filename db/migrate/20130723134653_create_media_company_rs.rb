class CreateMediaCompanyRs < ActiveRecord::Migration
  def change
    create_table :media_company_rs do |t|
      t.integer :company_id
      t.integer :media_site_id

      t.timestamps
    end
  end
end
