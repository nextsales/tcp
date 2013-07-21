class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :update_key
      t.string :update_type
      t.text :raw_data

      t.timestamps
    end
    add_index :feeds, :update_key
  end
end
