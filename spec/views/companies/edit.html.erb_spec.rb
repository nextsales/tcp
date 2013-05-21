require 'spec_helper'

describe "companies/edit" do
  before(:each) do
    @company = assign(:company, stub_model(Company,
      :name => "MyString",
      :description => "MyText",
      :address => "MyString",
      :city => "MyString",
      :country => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :postcode => "MyString",
      :website => "MyString",
      :facebook_id => "MyString",
      :linkedin_id => "MyString",
      :twitter_id => "MyString"
    ))
  end

  it "renders the edit company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path(@company), :method => "post" do
      assert_select "input#company_name", :name => "company[name]"
      assert_select "textarea#company_description", :name => "company[description]"
      assert_select "input#company_address", :name => "company[address]"
      assert_select "input#company_city", :name => "company[city]"
      assert_select "input#company_country", :name => "company[country]"
      assert_select "input#company_email", :name => "company[email]"
      assert_select "input#company_phone", :name => "company[phone]"
      assert_select "input#company_postcode", :name => "company[postcode]"
      assert_select "input#company_website", :name => "company[website]"
      assert_select "input#company_facebook_id", :name => "company[facebook_id]"
      assert_select "input#company_linkedin_id", :name => "company[linkedin_id]"
      assert_select "input#company_twitter_id", :name => "company[twitter_id]"
    end
  end
end
