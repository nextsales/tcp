class CreateCompanyCompetenceRs < ActiveRecord::Migration
  def change
    create_table :company_competence_rs do |t|
      t.integer :competence_id
      t.integer :company_id

      t.timestamps
    end
  end
end
