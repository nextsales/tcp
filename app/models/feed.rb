class Feed < ActiveRecord::Base
  attr_accessible :company_id, :content, :feed_type, :likes, :origin_created_time, :photo_url, :shares, :title, :url
  
  belongs_to :company
  
  has_many :feed_matrix_rs, :dependent => :destroy
  has_many :matrices, :through => :feed_matrix_rs
end
