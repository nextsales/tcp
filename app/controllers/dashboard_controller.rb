class DashboardController < ApplicationController
  before_filter :authenticate_user!
  def index
  end
  
  def test
  end
  
  def testlinkedin
    raise get_company_data(76012).to_yaml
  end
  
  def get_company_data(id)
    current_user.linkedin_client.company(:id => id, :fields => %w{ id name email-domains industry logo-url specialties description locations:(address:(city state country-code) is-headquarters) employee-count-range })
  end
  
  def search_company(keyword)
    current_user.linkedin_client.search({ :keywords => keyword}, "company").companies.all
  end
end
