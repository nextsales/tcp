class AddLinkedinAuthIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_auth_id, :integer
  end
end
