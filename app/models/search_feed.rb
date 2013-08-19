class SearchFeed < ActiveRecord::Base
  attr_accessible :feed_key, :feed_type, :origin_created_time, :raw_content
  
  has_many :search_feed_matrix_keyword_rs, :dependent => :destroy
  has_many :matrix_keywords, :through => :search_feed_matrix_keyword_rs
end
