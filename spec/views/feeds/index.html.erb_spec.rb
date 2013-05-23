require 'spec_helper'

describe "feeds/index" do
  before(:each) do
    assign(:feeds, [
      stub_model(Feed,
        :title => "Title",
        :photo_url => "Photo Url",
        :company_id => 1,
        :url => "Url",
        :shares => 2,
        :likes => 3,
        :matrix_id => 4,
        :content => "MyText",
        :feed_type => "Feed Type"
      ),
      stub_model(Feed,
        :title => "Title",
        :photo_url => "Photo Url",
        :company_id => 1,
        :url => "Url",
        :shares => 2,
        :likes => 3,
        :matrix_id => 4,
        :content => "MyText",
        :feed_type => "Feed Type"
      )
    ])
  end

  it "renders a list of feeds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Feed Type".to_s, :count => 2
  end
end
