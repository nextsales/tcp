namespace :crawl do
  desc "crawl Linkedin companies updates"
  task linkedin: :environment do
    linkedin_feeds
  end
end

def linkedin_feeds
  require 'rubygems'
  require 'oauth'
  require 'json'
  require 'date'
  
  # get your api keys at https://www.linkedin.com/secure/developer
  consumer = OAuth::Consumer.new('62vxqawt0fy2', 'JiXFk6AaYLKBErM1')
  access_token = OAuth::AccessToken.new(consumer, 'a0d0d1f1-eb24-4dfe-8fd9-19d75fa2e984', 'dcbbc84d-b065-4b86-8d61-23d170126719')
  
  json_txt = access_token.get("http://api.linkedin.com/v1/companies/1070/updates/key=UNIU-c1070-5740568913708597248-SHARE").body
  #updates = JSON.parse(json_txt)
  puts json_txt
  return
  
  # Go through all the companies
  companies = Company.all
  companies.each do |company|
    puts "geting updates of " + company.name
    if company.linkedin_id?
      company_updates(access_token, company,'json')
      return
    end
  end
end

# Parse updates of a company
def company_updates (access_token, company, format)
  url = "http://api.linkedin.com/v1/companies/" + company.linkedin_id.to_s + "/updates?count=100&format=" + format
  json_txt = access_token.get(url).body
  data = JSON.parse(json_txt)
  if data["_total"] == 0
    puts "No update in "+ company.linkedin_id.to_s
    return
  else
    puts data["values"]
    return
    updates = data["values"]
    updates.each do |update|
      updateContent = update["updateContent"]
      
      #A status update
      if updateContent.has_key?("companyStatusUpdate")
        status_update(company, update)
      end
      
      #A job posting
      if updateContent.has_key?("companyJobUpdate")
        job_posting(company, update)
      end
      
      #A personal update
      if updateContent.has_key?("companyPersonUpdate")
        companyPersonUpdate = updateContent["companyPersonUpdate"]
        action = companyPersonUpdate ["action"]
        
        #new hiring
        if action["code"] == "joined"
          new_hiring(company, update)
        end
        #postion change
        if action["code"] == "changed-position"
          position_change(company, update)
        end
      end
    end
  end
end

def position_change(company, update)
  feed = Feed.new()
  feed.company = company
  feed.feed_type = 'li'
  feed.likes = update["numLikes"]
  feed.origin_created_time = Time.at(update["timestamp"]/1000).to_datetime
  
  updateContent = update["updateContent"]
  companyPersonUpdate = updateContent["companyPersonUpdate"]
  person = companyPersonUpdate["person"]
  
  siteStandardProfileRequest = person["siteStandardProfileRequest"]
  if siteStandardProfileRequest.has_key("url")
    feed.url = siteStandardProfileRequest["url"]
  end
  
  new_pos = companyPersonUpdate["newPosition"]

  old_pos = companyPersonUpdate["oldPosition"]
  old_company = old_pos["company"]
  
  feed.url = "%s %s is now %s, previously titled %s at %s." %
        [person["firstName"], person["lastName"], new_pos["title"], old_pos["title"],old_company["name"]]

  #save to system
  feed.save
  #update associated matrices
  if company.matrices.any?
    matrices = company.matrices
    matrices.each do |matrix|
      matrix.feed_matrix_rs.build(feed_id: feed.id).save
    end
  end
end

def new_hiring(company, update)
  feed = Feed.new()
  feed.company = company
  feed.feed_type = 'li'
  feed.likes = update["numLikes"]
  feed.origin_created_time = Time.at(update["timestamp"]/1000).to_datetime
  
  updateContent = update["updateContent"]
  companyPersonUpdate = updateContent["companyPersonUpdate"]
  person = companyPersonUpdate["person"]

  siteStandardProfileRequest = person["siteStandardProfileRequest"]
  if siteStandardProfileRequest.has_key("url")
    feed.url = siteStandardProfileRequest["url"]
  end
  
  new_pos = companyPersonUpdate["newPosition"]
  new_company = new_pos["company"]

  old_pos = companyPersonUpdate["oldPosition"]
  old_company = old_pos["company"]

  if old_pos.has_key?("title")
    feed.content = "%s %s is now at %s. Worked as %s." % 
          [person["firstName"], person["lastName"], new_pos["title"], new_company["name"],old_pos["title"],old_company["name"]]
  else
    feed.content = "%s %s is now at %s." %  [person["firstName"], person["lastName"], new_pos["title"], new_company["name"]]
  end
  
  #save to system
  feed.save
  #update associated matrices
  if company.matrices.any?
    matrices = company.matrices
    matrices.each do |matrix|
      matrix.feed_matrix_rs.build(feed_id: feed.id).save
    end
  end
end


def job_posting(company, update)
  feed = Feed.new()
  feed.company = company
  feed.feed_type = 'li'
  feed.likes = update["numLikes"]
  feed.origin_created_time = Time.at(update["timestamp"]/1000).to_datetime
  
  updateContent = update["updateContent"]
  companyJobUpdate = updateContent["companyJobUpdate"]
  job = companyJobUpdate["job"]
  
  tmp = "%s is hiring: " % company.name
  if job.has_key?("position")
    pos=job["position"]
    tmp = "%s %s" %[tmp, pos["title"]]
  end
  if job.has_key?("locationDescription")
    tmp = "%s in %s" % [tmp, job["locationDescription"]]
  end
  
  feed.content=tmp
  
  if job.has_key?("siteJobRequest")
    req=job["siteJobRequest"]
    feed.url = req["url"]
  end
  
  #save to system
  feed.save
  #update associated matrices
  if company.matrices.any?
    matrices = company.matrices
    matrices.each do |matrix|
      matrix.feed_matrix_rs.build(feed_id: feed.id).save
    end
  end
end

def status_update (company, update)
  feed = Feed.new()
  feed.company = company
  feed.feed_type = 'li'
  feed.likes = update["numLikes"]
  feed.origin_created_time = Time.at(update["timestamp"]/1000).to_datetime
  
  updateContent = update["updateContent"]
  companyStatusUpdate= updateContent["companyStatusUpdate"]
  share = companyStatusUpdate["share"]

  if share.has_key?("comment")
    comment = share["comment"]
  end
  
  if share.has_key?("content")
    content = share["content"]
    if content.has_key?("description")
      desc = content["description"]
      if desc
        feed.content = desc
      elsif comment
        feed.content = comment
      end
    end
    
    if content.has_key?("submittedImageUrl")
        feed.photo_url = content["submittedImageUrl"]
    end
    
    if content.has_key?("submittedUrl")
      feed.url = content["submittedUrl"]
    end
    
    if content.has_key?("title")
      feed.title = content["title"]
    end    
  end

  #save to system
  feed.save
  #update associated matrices
  if company.matrices.any?
    matrices = company.matrices
    matrices.each do |matrix|
      matrix.feed_matrix_rs.build(feed_id: feed.id).save
    end
  end
end