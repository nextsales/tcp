class CrawlerController < ApplicationController
  before_filter :authenticate_user!
  
  def testlinkedin
    
    #raise get_all_updates_by_keyword("digital").to_yaml
    
    #raise search_company("digital").to_yaml
    
    crawl_linkedin_update(162479)
    
    raise get_company_updates(45709).to_yaml
    
    raise get_company_update(45709,"UNIU-c45709-5720127452898918400-SHARE")
    
    
    #raise current_user.linkedin_client.profile(:url => 'http://www.linkedin.com/pub/pham-quang/50/316/72').to_yaml
    #raise get_company_data(79870).to_yaml
    #raise get_company_update(79870,"UNIU-c79870-5748859230270525440-FOLLOW_CMPY").to_yaml
    raise get_company_updates(79870).to_yaml
    
    @update = []
    @update.push(get_company_update(79870,"UNIU-c79870-5748859230270525440-FOLLOW_CMPY"));
    @update.push(get_company_update(79870,"UNIU-c79870-5739788179427307520-FOLLOW_CMPY"));
    
    raise @update.to_yaml
  end
  
  def get_company_data(id)
    #http://api.linkedin.com/v1/companies/1337:(id,name,ticker,description)
    current_user.linkedin_client.company(:id => id, :fields => %w{ id name email-domains industry logo-url specialties description locations:(address:(city state country-code) is-headquarters) employee-count-range })
  end
  
  def get_company_update(id, update_key)
    #http://api.linkedin.com/v1/companies/{id}/updates/key=UNIU-c79870-5750255531205861376-FOLLOW_CMPY
    current_user.linkedin_client.company_update(update_key, {:id => id});
  end
  
  def get_company_updates(id)
    #http://api.linkedin.com/v1/companies/{id}/updates
    current_user.linkedin_client.company_updates({:id => id, :count => 3000, :start => 0});
  end
  
  def search_company(keyword)
    # go to companies.all
    #current_user.linkedin_client.search({ :keywords => keyword}, "company").companies.all
    current_user.linkedin_client.search({:keywords => keyword}, "company")
  end
  
  def get_all_updates_by_keyword(keyword)
    company_updates = []
    search_company(keyword).companies.all.each do |company|
      company_updates += get_company_updates(company.id).all if (get_company_updates(company.id).all)
    end
    company_updates
  end
  
  def crawl_linkedin_update(linkedin_company_id)
    current_user.linkedin_client.company_updates({:id => linkedin_company_id, :count => 9999, :start => 0}).all.each do |update|
      if LinkedinUpdate.find_by_update_key(update.update_key)
        return
      end
      LinkedinUpdate.create(:linkedin_company_id => linkedin_company_id, :raw_data => update.to_json, :update_key => update.update_key, :update_type => update.update_type, :created_at => update.timestamp)
    end
  end
  
  def crawl_suggested_companies
    a = []
    User.all.each do |user|
      next if !user.linkedin_uid
      linkedin_client = user.linkedin_client
      
      # Start crawling following companies
      start = 0
      count = 25
      while (true)
         query = linkedin_client.following_companies(:start => start, :count => count)
         save_suggested_company(user, query.all, 10)
         start = start + count
         break if (start > query.total) 
      end
      # End crawling following companies
      
      # Start crawling suggested companies by linkedin
      query = linkedin_client.following_companies_suggestions(count: 25)
      save_suggested_company(user, query.all, 10)
      # End crawling suggested companies by linkedin
      
    end
    
    raise a.to_yaml
  end
  
  def save_suggested_company(user, companies, rank)
    companies.each do |c|
      next if SuggestedCompany.where(user_id: user.id, linkedin_id: c.id)
      detail_data = user.linkedin_client.company(:id => c.id, :fields => %w{id name logo-url})
      suggested_com = SuggestedCompany.create(user_id: user.id, linkedin_id: detail_data.id, name: detail_data.name, logo_url: detail_data.logo_url, rank: rank)
    end
  end
  
  
end
