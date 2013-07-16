class CreateMediaSites < ActiveRecord::Migration
  def change
    create_table :media_sites do |t|
      t.string :name

      t.timestamps
    end
  end
end
