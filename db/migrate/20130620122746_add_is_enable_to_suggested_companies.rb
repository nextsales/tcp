class AddIsEnableToSuggestedCompanies < ActiveRecord::Migration
  def change
    add_column :suggested_companies, :is_enable, :boolean, :default => true
  end
end
