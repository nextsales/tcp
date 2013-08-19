namespace :crawl do
  desc "Search Twitter tweets by keywords"
  task twitter_search: :environment do
    twitter_search_by_keywords
  end
end

def twitter_search_by_keywords
  days = 7
  Matrix.all.each do |matrix|
    user = matrix.user
    puts user.id.to_s + " is processing " + matrix.name
    next if !user.twitter_uid # skip if the user has not added his Twitter account
    next if !matrix.matrix_keywords.any? # skip if no keywords
    twitter_client = user.twitter_client
    
    #search all the tweets for each keyword in the matrix
    matrix.matrix_keywords.each do |keyword|
      search_by_keyword(twitter_client, keyword, days)
    end
  end
end

def search_by_keyword(client, keyword, days)
  last_time = Time.now 
  before_time = last_time- days.day
  max_id = 0
  q = keyword.name
  while (last_time > before_time)
    if max_id == 0
      feeds = client.search(q, :count => 100,:result_type => "recent")
    else
      feeds = client.search(q, :count => 100,:max_id => max_id, :result_type => "recent")
    end
    break unless feeds && feeds.results.any?
    max_id = feeds.results.last.id - 1
    last_time = feeds.results.last.created_at
    
    #put to the database
    feeds.results.each do |feed|
      search_feed = Hash.new
      search_feed["feed_key"] = feed.id.to_s
      search_feed["origin_created_time"] = feed.created_at.to_datetime
      search_feed["raw_content"] = feed.attrs.to_s
      search_feed["feed_type"] = "Twitter.com"
      
      #if exists, update else create 
      feed_tmp = SearchFeed.find_or_create_by_feed_key(feed.id.to_s)
      feed_tmp.update_attributes(search_feed)
      keyword.search_feed_matrix_keyword_rs.build(search_feed_id: feed_tmp.id).save
    end
  end
  
end

