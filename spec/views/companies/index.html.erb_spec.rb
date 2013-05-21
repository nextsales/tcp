require 'spec_helper'

describe "companies/index" do
  before(:each) do
    assign(:companies, [
      stub_model(Company,
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
      ),
      stub_model(Company,
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
      )
    ])
  end

  it "renders a list of companies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Postcode".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => "Facebook".to_s, :count => 2
    assert_select "tr>td", :text => "Linkedin".to_s, :count => 2
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
  end
end
