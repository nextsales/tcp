require 'spec_helper'

describe "competences/edit" do
  before(:each) do
    @competence = assign(:competence, stub_model(Competence,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit competence form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => competences_path(@competence), :method => "post" do
      assert_select "input#competence_name", :name => "competence[name]"
      assert_select "textarea#competence_description", :name => "competence[description]"
    end
  end
end
