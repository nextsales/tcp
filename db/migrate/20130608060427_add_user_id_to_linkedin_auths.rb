class AddUserIdToLinkedinAuths < ActiveRecord::Migration
  def change
    add_column :linkedin_auths, :user_id, :integer
  end
end
