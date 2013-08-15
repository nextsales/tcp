class TwitterTweetLastId < ActiveRecord::Base
  attr_accessible :company_id, :matrix_id, :tweet_last_id
  belongs_to :matrix
  belongs_to :company 
end
