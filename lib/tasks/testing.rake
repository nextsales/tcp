namespace :cron do
  desc "import feeds"
  task test: :environment do
    linkedin_feeds
  end
end

def linkedin_feeds1
  puts "hung"
end