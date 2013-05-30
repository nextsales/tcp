namespace :crawl do
  desc "use site search in google"
  task monitor: :environment do
    site_monitor
  end
end

def site_monitor
  require 'open-uri'
  require 'nokogiri'
  
  # Perform a google search
  doc = Nokogiri::HTML(open('http://www.google.com/search?ie=UTF-8&oe=UTF-8&as_sitesearch=nokia.com&tbs=qdr:w1,date:1'))
  #puts doc
  html_parser(doc)
end

def html_parser(doc)
  # Print out each link using a CSS selector
  doc.css('li.g').each do |hit|
    h3 = hit.at_css('h3.r a')
    title= h3.content
    url_tmp=h3[:href]
    url = url_tmp[/q=(.*?)\&/,1]
    
    st = hit.at_css('span.st')
    puts st
  end
  
  
end
