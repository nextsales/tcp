namespace :cron do
  desc "import feeds"
  task test: :environment do
    linkedin_feeds
  end
end

def linkedin_feeds
  puts "hung"
end