class FacebookFeed < ActiveRecord::Base
  attr_accessible :company_id, :content, :is_top, :matrix_id, :title, :url
  belongs_to :matrix
  belongs_to :company
end
