namespace :crawl do
  desc "use site search in google"
  task monitor: :environment do
    google_search
  end
end

def google_search
  require 'open-uri'
  require 'nokogiri'
  
  # Perform a google search
  doc = Nokogiri::HTML(open('http://google.com/search?q=tenderlove'))
  puts doc
  # Print out each link using a CSS selector
  doc.css('h3.r > a.l').each do |link|
    puts link.content
  end
  
  
  doc.css('a').each do |link|
    if link['href'] =~ /\b.+.pdf/
      begin
        File.open('filename_to_save_to.pdf', 'wb') do |file|
          downloaded_file = open(link['href'])
          file.write(downloaded_file.read())
        end
      rescue => ex
        puts "Something went wrong...."
      end
    end
  end
end