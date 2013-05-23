class Feed < ActiveRecord::Base
  attr_accessible :company_id, :content, :feed_type, :likes, :matrix_id, :origin_created_time, :photo_url, :shares, :title, :url
  belongs_to :matrix
  belongs_to :company
end
