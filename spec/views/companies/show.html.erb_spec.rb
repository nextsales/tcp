require 'spec_helper'

describe "companies/show" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :name => "Name",
      :description => "MyText",
      :address => "Address",
      :city => "City",
      :country => "Country",
      :email => "Email",
      :phone => "Phone",
      :postcode => "Postcode",
      :website => "Website",
      :facebook_id => "Facebook",
      :linkedin_id => "Linkedin",
      :twitter_id => "Twitter"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Address/)
    rendered.should match(/City/)
    rendered.should match(/Country/)
    rendered.should match(/Email/)
    rendered.should match(/Phone/)
    rendered.should match(/Postcode/)
    rendered.should match(/Website/)
    rendered.should match(/Facebook/)
    rendered.should match(/Linkedin/)
    rendered.should match(/Twitter/)
  end
end
