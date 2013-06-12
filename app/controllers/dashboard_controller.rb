class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
  
  def test
  end
  
  def testlinkedin
    #raise current_user.linkedin_client.profile(:url => 'http://www.linkedin.com/pub/pham-quang/50/316/72').to_yaml
    #raise get_company_data(79870).to_yaml
    raise get_company_update(79082).to_yaml
  end
  
  def get_company_data(id)
    #http://api.linkedin.com/v1/companies/1337:(id,name,ticker,description)
    current_user.linkedin_client.company(:id => id, :fields => %w{ id name email-domains industry logo-url specialties description locations:(address:(city state country-code) is-headquarters) employee-count-range })
  end
  
  def get_company_update(id)
    #http://api.linkedin.com/v1/companies/{id}/updates
    current_user.linkedin_client.company_updates(:id => id);
  end
  
  def search_company(keyword)
    # go to companies.all
    #current_user.linkedin_client.search({ :keywords => keyword}, "company").companies.all
    current_user.linkedin_client.search({ :keywords => keyword}, "company")
  end
end
