class CreateSearchFeedMatrixKeywordRs < ActiveRecord::Migration
  def change
    create_table :search_feed_matrix_keyword_rs do |t|
      t.integer :search_feed_id
      t.integer :matrix_keyword_id

      t.timestamps
    end
    add_index(:search_feed_matrix_keyword_rs, :search_feed_id)
    add_index(:search_feed_matrix_keyword_rs, :matrix_keyword_id)
  end
end
