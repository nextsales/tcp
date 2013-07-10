namespace :crawl do
  desc "use site search in google"
  task monitor: :environment do
    site_monitor
  end
end

def site_monitor
  require 'open-uri'
  require 'nokogiri'
  require 'fastimage'
  
  # Perform a google search
  #doc = Nokogiri::HTML(open('http://www.google.com/search?ie=UTF-8&oe=UTF-8&as_sitesearch=nokia.com&tbs=qdr:w1,date:1'))
  #puts doc
  #html_parser(doc)
  url2thumbnail ("http://www.starzik.com/")
end



def html_parser(doc)
  # Print out each link using a CSS selector
  doc.css('li.g').each do |hit|
    h3 = hit.at_css('h3.r a')
    title= h3.content
    url_tmp=h3[:href]
    url = url_tmp[/q=(.*?)\&/,1]
    
    st = hit.at_css('span.st')
    
  end 
  
end

def url_fetcher(url)
  begin
    page = Nokogiri::HTML(open(url))    
    page
  rescue OpenURI::HTTPError => ex
      puts "problem with " + url
      return nil
      
  end 
end

def url2thumbnail (url)
  page = url_fetcher(url)
  return nil unless page

  # First use opengraph parsing, if not applied then use a custom algorithm
  thumbnail =  opengraph(page) || custom(page)
  return nil unless thumbnail
  thumbnail
end

#list all the images, rank them based on their size.
def custom(page)
  
  images = img_srcs(page)
  img_size_list = []  
  count = 0
  images.each do |img|
    break if count >= 10
    size = FastImage.size(img)
    next unless size
    img_size_list.push({"url" => img, "size" => size.min})
    count += 1
  end
  
  if img_size_list.count <= 1
     biggest_img = img_size_list.first
     biggest_img_url = biggest_img["url"]
  else
    img_size_list_sorted = img_size_list.sort{|a,b| b["size"] <=> a["size"]}
    biggest_img_url = img_size_list_sorted.first["url"]
  end
  biggest_img_url
end

def img_srcs(page)
  img_src_list = page.css('img').map{ |i| i['src'] }
  img_src_list
end

def opengraph?(page)
  !page.xpath('//meta[starts-with(@property, "og:") and @content]').empty?
end

def opengraph(page)
  return nil unless opengraph?(page)
  opengraph_parse(page)
end

def opengraph_parse(page)
  object = Hash.new
  page.css('meta').each do |m|
    if m.attribute('property') && m.attribute('property').to_s.match(/^og:(.+)$/i)
      object[$1.gsub('-', '_')] = m.attribute('content').to_s
    end
  end
  return nil unless object["image"]
  
  object_url = object["image"] 
  page = url_fetcher(object_url)
  return nil unless page
  object_url
end