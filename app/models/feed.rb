class Feed < ActiveRecord::Base
  attr_accessible :raw_data, :update_key, :update_type, :created_at
  has_many :matrix_feed_rs
  has_many :matrices, :through => :matrix_feed_rs
end
