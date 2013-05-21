class CreateMatrices < ActiveRecord::Migration
  def change
    create_table :matrices do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
