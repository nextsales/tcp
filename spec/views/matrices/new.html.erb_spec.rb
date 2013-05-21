require 'spec_helper'

describe "matrices/new" do
  before(:each) do
    assign(:matrix, stub_model(Matrix,
      :name => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new matrix form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => matrices_path, :method => "post" do
      assert_select "input#matrix_name", :name => "matrix[name]"
      assert_select "textarea#matrix_description", :name => "matrix[description]"
    end
  end
end
