require 'spec_helper'

describe "competences/show" do
  before(:each) do
    @competence = assign(:competence, stub_model(Competence,
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
  end
end
