class CreateCompanyIndustryRs < ActiveRecord::Migration
  def change
    create_table :company_industry_rs do |t|
      t.integer :industry_id
      t.integer :company_id

      t.timestamps
    end
  end
end
