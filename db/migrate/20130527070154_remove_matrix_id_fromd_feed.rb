class RemoveMatrixIdFromdFeed < ActiveRecord::Migration
  def up
    remove_column :feeds, :matrix_id
  end

  def down
  end
end
