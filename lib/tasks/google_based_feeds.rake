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
  #requested_url = "https://www.google.com/search?ie=UTF-8&oe=UTF-8&as_q=Lumia&as_sitesearch=nokia.com&tbs=qdr:d1,sbd:1"
  #keywords = []
  #keywords << "lumia"
  #keywords << "applications"
  #hits = site_search_with_keywords("nokia.com", keywords, "d1", "date", 1)
  matrix1 = Matrix.first
  matrix_media_monitor(matrix1, "m1", "date")
end

def matrix_media_monitor(matrix, past, sort_by)
  media_sites = matrix.media_sites.all
  keywords = matrix.matrix_keywords.map(&:name)
  
  companies = matrix.companies
  
  
  if companies.any?
    companies.each do |company|
      
      #Monitor the websites of the companies with keywords
      website_hits = site_search_with_keywords(company.website, keywords, past, sort_by, 0)
      #puts website_hits
      
      # monitor public media about the companies
      # Get all the hits whose title contain the company's name
      company_name = company_name_processing(company.name)
      media_sites.each do |site|
        #puts "site: %s" % [site.name]
        hits = site_search_with_keywords(site.name, company_name, past, sort_by, 1)
        puts hits
      end
    end
  end 
  
end

def company_name_processing(name)
  array = ["oy", "ay", "ky", "oyj", "ok", "ry", "inc", "inc.", "ltd", "ltd.", "corp.", "corp", "corporation", "incorporation"]
  name1 = name.split.delete_if{|x| array.include?(x.downcase)}.join(' ')
  
  names = []
  names << name1.gsub(/ /, "%20AND%20")
  names
end

def site_search_with_keywords(site, keywords, past, sort_by, is_ontitle)
  return nil unless site
  
  if sort_by == "date" 
    sort_by_tmp = "sbd:1"
  elsif sort_by == "relevance"
    sort_by_tmp = "sbr:1"
  else
    return nil
  end
  kw_str = keywords.join(" OR ").gsub(/ /,'%20')
  if is_ontitle == 1
    puts keywords
    puts kw_str
    requested_url = "https://www.google.com/search?ie=UTF-8&oe=UTF-8&as_q=%s&as_occt=title&as_sitesearch=%s&tbs=qdr:%s,%s" % [kw_str, site, past, sort_by_tmp]
  else
    requested_url = "https://www.google.com/search?ie=UTF-8&oe=UTF-8&as_q=%s&as_sitesearch=%s&tbs=qdr:%s,%s" % [kw_str, site, past, sort_by_tmp]
  end
  page = url_fetcher(requested_url)
  return nil unless page
  
  google_hits = []
  #parse Google search results
  html_parser(page, requested_url, google_hits)
  google_hits
end
def html_parser(doc, query_url, hits)
  # Print out each link using a CSS selector
  doc.css('li.g').each do |hit_tag|
    hit = Hash.new
    h3 = hit_tag.at_css('h3.r a')
    hit["title"]= h3.content
    
    url_tmp=h3[:href]
    hit["url"] = url_tmp[/q=(.*?)\&/,1]
    
    hit["content"] = hit_tag.at_css('span.st').text
    hit["feed_type"] = "media_site_feed"
    thumbnail = url2thumbnail(hit["url"])
    if thumbnail
      hit["photo_url"] = thumbnail
    end
    #puts hit
    hits.push(hit)
  end 
  doc.css('td.b a').each do |tag|
    content = tag.content
    if content == "Next"
      tmp = tag[:href] 
      start = tmp[/start=\d+/,0]
      requested_url = "%s&%s" % [query_url, start]
      #puts requested_url
      sleep rand(4) + 2 # uniform random number [2,5]
      page = url_fetcher(requested_url)
      if page
        html_parser(page, query_url, hits)
      end
    end 
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
     return nil unless biggest_img
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
  if object["image"].start_with?('//')
    object_url = "http:%s" % [object["image"]]
  else
    object_url = object["image"]
  end 
  page = url_fetcher(object_url)
  return nil unless page
  object_url
end