class AddIsApprovedToCompetence < ActiveRecord::Migration
  def change
    add_column :competences, :is_approve, :boolean
  end
end
