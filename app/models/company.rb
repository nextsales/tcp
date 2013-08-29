class Company < ActiveRecord::Base
  attr_accessible :address, :city, :country, :description, :email, :facebook_id, :linkedin_id, :name, :phone, :postcode, :twitter_id, :website, :logo_url
  #validates :user_id, presence: true
  
  has_one :user_company_r
  has_one :user, :through => :user_company_r
  
  has_many :company_industry_rs, :dependent => :destroy
  has_many :competences, :through => :company_competence_rs

  has_many :company_competence_rs, :dependent => :destroy
  has_many :industries, :through => :company_industry_rs
  
  has_many :company_matrix_rs, :dependent => :destroy
  has_many :matrices, :through => :company_matrix_rs
  
  has_many :twitter_tweet_last_ids
  
  attr_reader :competence_tokens, :industry_tokens, :matrix_tokens, :add_matrix
  attr_accessible :competence_tokens, :industry_tokens, :matrix_tokens, :matrix_ids, :industry_ids, :competence_ids, :add_matrix
  
  def competence_tokens=(tokens)
    self.competence_ids = Competence.ids_from_tokens(tokens).uniq
  end
  
  def industry_tokens=(ids)
    self.industry_ids = ids.split(",")
  end
  
  def matrix_tokens=(ids)
    self.matrix_ids = ids.split(",")
  end
  
  def exist?
    if self.linkedin_id
      company = Company.find_by_linkedin_id(self.linkedin_id)
      if company
        return true
      end
    end
    if self.name
      company = Company.find_by_name(self.name)
      if company
        return true
      end
    end
    return false
  end

  def add_matrix=(id)
    self.matrix_ids = self.matrix_ids.push(id)
  end
  
  
  # Should move to company crawl #
  def crawl_linkedin_update(linkedin_client, updates_count, start_id)
    return nil unless linkedin_client && self.linkedin_id != ''
    feeds = Array.new
    if (crawl_results = linkedin_client.company_updates({:id => self.linkedin_id, :count => updates_count, :start => start_id}).all)
      crawl_results.each do |update|
        feed = linkedin_update2feed(update)
        if feed
          feeds.push(feed)
        end
      end
      next_start_id = start_id + crawl_results.count
    end
    return [feeds, next_start_id]
  end
  
  def crawl_twitter_tweets(twitter_client, tweets_count, max_id)
    return nil unless twitter_client && self.twitter_id != ''
    puts twitter_client.to_s
    feeds = Array.new
    if max_id == 0
      tweets = twitter_client.user_timeline(self.twitter_id, :count => tweets_count)
    else
      tweets = twitter_client.user_timeline(self.twitter_id, :count => tweets_count, :max_id => max_id)
    end
       
    return nil, nil  unless tweets
    ids = tweets.map(&:id)
    last_id = ids.min # the id of the oldest tweet that has been fetched
    
    #create instant feeds
    tweets.each do |tweet|
      feed = tweet2feed(tweet)
      feeds.push(feed)
    end
    return [feeds, last_id]
  end
  
  def tweet2feed(tweet)
    return nil unless tweet
    #if tweet.id == 365731885118267394
    #  raise  tweet.to_yaml
    #end
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
  
    
  def linkedin_update2feed(update)
    return nil unless update.update_content
    if update.update_content.company_job_update
      feed = job_posting(update, self)
    end
    return nil unless feed
    feed
  end
  
  
  def job_posting(update, company)
    feed = InstantFeed.new
    feed.feed_type = 'li_update'
    #feed.likes = update["numLikes"]
    feed.origin_created_time = update.timestamp
    job = update.update_content.company_job_update.job
    
    feed.content = job.description
    feed.url = job.site_job_request.url
    
    position = job.position
    
    feed.title = "%s is hiring: %s in %s" % [company.name, position.title, job.location_description]
    feed
  end
end
