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
    
  def crawl_feed(tweets_count)
    feeds = Array.new
    #linkedin_client = self.user.linkedin_client
    twitter_client = self.user.twitter_client
    
    self.companies.each do |company|
      #if linkedin_client && company.linkedin_id
      #  li_feeds = crawl_linkedin_update(linkedin_client, company)
      #  if li_feeds
      #    feeds.push(li_feeds)
      #  end
      #end
      if twitter_client && company.twitter_id
        tw_feeds = crawl_twitter_tweets(twitter_client, company, tweets_count)
        if tw_feeds
          feeds  = feeds + tw_feeds
        end
      end
    end
    feeds
  end
  
  # Should move to company crawl #
  def crawl_linkedin_update(linkedin_client, company)
    if (crawl_results = linkedin_client.company_updates({:id => company.linkedin_id, :count => 9999, :start => 0}).all)
      crawl_results.each do |update|
        linkedin_update = Feed.where(update_key: update.update_key).first_or_create(:raw_data => update.to_json, :update_key => update.update_key, :update_type => update.update_type, :created_at => update.timestamp)
        MatrixFeedR.find_or_create_by_matrix_id_and_feed_id(matrix_id: self.id, feed_id: linkedin_update.id)
      end
    end
  end
  
  def crawl_twitter_tweets(twitter_client, company, tweets_count)
    feeds = Array.new
    #last_id = get_twitter_tweet_last_id_of(company)
    #if last_id # Fetch the tweets up to last_id-1
    #  tweets = twitter_client.user_timeline(company.twitter_id, :count => tweets_count, :max_id => last_id)
    #else
    # tweets = twitter_client.user_timeline(company.twitter_id, :count => tweets_count) 
    #end
    
    tweets = twitter_client.user_timeline(company.twitter_id, :count => tweets_count) 
    return nil unless tweets
    ids = tweets.map(&:id)
    last_id = ids.min # the id of the oldest tweet that has been fetched
    
    #save the last id
    if last_id
      TwitterTweetLastId.create!(:tweet_last_id => last_id, :company_id => company.id, :matrix_id => self.id)
    end
    #create instant feeds
    tweets.each do |tweet|
      feed = tweet2feed(tweet)
      feeds.push(feed)
    end
    feeds
  end
  
  #Get the id of the oldest tweet that has been fetched
  def get_twitter_tweet_last_id_of(company)
    if self.twitter_tweet_last_ids.any? && company.twitter_tweet_last_ids.any?
      ids = self.twitter_tweet_last_ids&& company.twitter_tweet_last_ids
      id = ids.first
      id
    else
      return nil
    end
  end
  
  def tweet2feed(tweet)
    return nil unless tweet
    #raise  tweet.to_yaml
    feed = InstantFeed.new
    feed.content = tweet.text
    feed.feed_type = "Twitter_tweet"
    feed.likes = tweet.favorite_count
    feed.shares = tweet.retweet_count
    feed.origin_created_time = tweet.created_at
    feed.url = "http://twitter.com/"+ tweet.from_user + '/status/' + tweet.id.to_s
    if tweet.media.any?
      feed.photo_url = tweet.media.first.media_url
    end
    feed.title = tweet.from_user + " tweeted at Twitter"
    #raise feed.to_yaml
    feed
  end
end