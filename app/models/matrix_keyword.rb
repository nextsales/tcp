class MatrixKeyword < ActiveRecord::Base
  attr_accessible :matrix_id, :name
  belongs_to :matrix
  
  has_many :search_feed_matrix_keyword_rs
  has_many :search_feeds, :through => :search_feed_matrix_keyword_rs
end
