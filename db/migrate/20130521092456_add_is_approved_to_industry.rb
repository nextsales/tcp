class AddIsApprovedToIndustry < ActiveRecord::Migration
  def change
    add_column :industries, :is_approve, :boolean
  end
end
