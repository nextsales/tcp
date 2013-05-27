class FeedMatrixR < ActiveRecord::Base
  attr_accessible :feed_id, :matrix_id  
  belongs_to :feed
  belongs_to :matrix
end
