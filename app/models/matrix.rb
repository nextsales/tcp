class Matrix < ActiveRecord::Base
  attr_accessible :description, :name
  
  has_many :matrix_keywords
  
  has_many :company_matrix_rs, :dependent => :destroy
  has_many :companies, :through => :company_matrix_rs
  
  has_one :user_matrix_r
  has_one :user, :through => :user_matrix_r
  
  has_many :matrix_follower_rs, dependent: :destroy
  has_many :followers, :through => :matrix_follower_rs
  
  has_many :matrix_feed_rs
  has_many :feeds, :through => :matrix_feed_rs
  
  has_many :twitter_tweet_last_ids
  
  attr_reader :company_tokens
  attr_accessible :company_tokens, :company_ids
  
  def company_tokens=(ids)
    self.company_ids = ids.split(",")
  end
  
  def self.tokens(query)
    matrices = where("name like ?", "%#{query}%")
    if matrices.empty?
      [{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
    else
      matrices
    end
  end
  
  def self.ids_from_tokens(tokens)
    tokens.gsub!(/<<<(.+?)>>>/) {create!(name: $1).id }
    tokens.split(',')
  end
    
  def crawl_feed(feeds_count, twitter_maxids, linkedin_start_ids)
    feeds = Array.new
    linkedin_client = self.user.linkedin_client
    twitter_client = self.user.twitter_client
    
    twitter_last_ids = Hash.new
    linkedin_next_start_ids = Hash.new
    self.companies.each do |company|
      # If the user has linkedin ID, crawl Linkedin
      if linkedin_client
        if linkedin_start_ids && linkedin_start_ids[company.id.to_s]
          li_feeds, next_start_id = company.crawl_linkedin_update(linkedin_client, feeds_count, linkedin_start_ids[company.id.to_s].to_i)
        else
          li_feeds, next_start_id = company.crawl_linkedin_update(linkedin_client, feeds_count,0)
        end
        if li_feeds
          feeds = feeds + li_feeds
        end
        if next_start_id
          linkedin_next_start_ids[company.id.to_s] = next_start_id
        end
      end
      # If the user has Twitter ID, crawl Twitter
      if twitter_client
        if twitter_maxids && twitter_maxids[company.id.to_s]
          tw_feeds, tw_id = company.crawl_twitter_tweets(twitter_client, feeds_count, twitter_maxids[company.id.to_s].to_i - 1)
        else
          tw_feeds, tw_id = company.crawl_twitter_tweets(twitter_client, feeds_count, 0)
        end
        if tw_feeds
          feeds  = feeds + tw_feeds
        end
        if tw_id
          twitter_last_ids[company.id.to_s] =  tw_id
        end
      end
    end
    [feeds, twitter_last_ids,linkedin_next_start_ids]
  end
  
  def contain?(company)
    if self.company_matrix_rs.find_by_company_id(company.id)
      return true
    else
      return false
    end
  end
  
  def followed_by?(user)
    if self.matrix_follower_rs.find_by_follower_id(user.id)
      return true
    else
      return false
    end
  end
  
end