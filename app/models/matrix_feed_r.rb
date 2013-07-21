class MatrixFeedR < ActiveRecord::Base
  attr_accessible :feed_id, :matrix_id
  belongs_to :matrix
  belongs_to :feed
end
