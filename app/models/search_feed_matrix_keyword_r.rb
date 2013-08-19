class SearchFeedMatrixKeywordR < ActiveRecord::Base
  attr_accessible :matrix_keyword_id, :search_feed_id
  belongs_to :matrix_keyword
  belongs_to :search_feed
end
