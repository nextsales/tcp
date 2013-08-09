class InstantFeed < ActiveRecord::Base
  attr_accessible :content, :feed_type, :likes, :origin_created_time, :photo_url, :shares, :title, :url
  #default_scope -> { order('origin_created_time DESC') }
end
