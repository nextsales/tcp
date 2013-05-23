class Feed < ActiveRecord::Base
  attr_accessible :company_id, :content, :feed_type, :likes, :matrix_id, :origin_created_time, :photo_url, :shares, :title, :url
end
