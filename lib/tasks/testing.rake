namespace :cron do
  desc "import feeds"
  task test: :environment do
    linkedin_feed
  end
end

def linkedin_feed
  puts "hung"
end