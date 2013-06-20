class AddIsEnableToSuggestedCompanies < ActiveRecord::Migration
  def change
    add_column :suggested_companies, :is_enable, :boolean, :default => true
    add_index :suggested_companies, :user_id
    add_index :suggested_companies, :linkedin_id
    add_index :suggested_companies, :rank
    add_index :suggested_companies, :is_enable
  end
end
