namespace :db do
  desc "import feeds"
  task import_feeds: :environment do
    import_linkedin_feeds
  end
end

def import_linkedin_feeds
  records = JSON.parse(File.read('datafiles/feeds.json'))
  records.each do |record|
    Feed.create!(record)
  end
end