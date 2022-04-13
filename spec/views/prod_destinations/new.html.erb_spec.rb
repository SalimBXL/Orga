require 'rails_helper'

RSpec.describe "prod_destinations/new", type: :view do
  before(:each) do
    assign(:prod_destination, ProdDestination.new(
      :name => "MyString"
    ))
  end

  it "renders new prod_destination form" do
    render

    assert_select "form[action=?][method=?]", prod_destinations_path, "post" do

      assert_select "input[name=?]", "prod_destination[name]"
    end
  end
end
