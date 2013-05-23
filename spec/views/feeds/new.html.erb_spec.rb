require 'spec_helper'

describe "feeds/new" do
  before(:each) do
    assign(:feed, stub_model(Feed,
      :title => "MyString",
      :photo_url => "MyString",
      :company_id => 1,
      :url => "MyString",
      :shares => 1,
      :likes => 1,
      :matrix_id => 1,
      :content => "MyText",
      :feed_type => "MyString"
    ).as_new_record)
  end

  it "renders new feed form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => feeds_path, :method => "post" do
      assert_select "input#feed_title", :name => "feed[title]"
      assert_select "input#feed_photo_url", :name => "feed[photo_url]"
      assert_select "input#feed_company_id", :name => "feed[company_id]"
      assert_select "input#feed_url", :name => "feed[url]"
      assert_select "input#feed_shares", :name => "feed[shares]"
      assert_select "input#feed_likes", :name => "feed[likes]"
      assert_select "input#feed_matrix_id", :name => "feed[matrix_id]"
      assert_select "textarea#feed_content", :name => "feed[content]"
      assert_select "input#feed_feed_type", :name => "feed[feed_type]"
    end
  end
end
