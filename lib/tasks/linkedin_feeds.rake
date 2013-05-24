namespace :db do
  desc "import feeds"
  task crawl_feeds: :environment do
    linkedin_feeds
  end
end

def get_matrices
  matrices = Matrix.all()
  matrices.each do |matrix|
    puts matrix.name
  end
end

def linkedin_feeds
  require 'rubygems'
  require 'oauth'
  require 'json'
  


  # get your api keys at https://www.linkedin.com/secure/developer
  consumer = OAuth::Consumer.new('62vxqawt0fy2', 'JiXFk6AaYLKBErM1')
  access_token = OAuth::AccessToken.new(consumer, 'a0d0d1f1-eb24-4dfe-8fd9-19d75fa2e984', 'dcbbc84d-b065-4b86-8d61-23d170126719')
  
  json_txt = access_token.get("http://api.linkedin.com/v1/companies/1070/updates?count=99999&format=json").body
  updates = JSON.parse(json_txt)
end


