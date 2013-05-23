require 'spec_helper'

describe "feeds/show" do
  before(:each) do
    @feed = assign(:feed, stub_model(Feed,
      :title => "Title",
      :photo_url => "Photo Url",
      :company_id => 1,
      :url => "Url",
      :shares => 2,
      :likes => 3,
      :matrix_id => 4,
      :content => "MyText",
      :feed_type => "Feed Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Photo Url/)
    rendered.should match(/1/)
    rendered.should match(/Url/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/MyText/)
    rendered.should match(/Feed Type/)
  end
end
