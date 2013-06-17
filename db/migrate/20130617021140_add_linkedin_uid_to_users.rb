class AddLinkedinUidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :linkedin_uid, :string
  end
  add_index :users, :linkedin_uid, :unique => true
end
