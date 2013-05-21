require 'spec_helper'

describe "matrices/index" do
  before(:each) do
    assign(:matrices, [
      stub_model(Matrix,
        :name => "Name",
        :description => "MyText"
      ),
      stub_model(Matrix,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of matrices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
