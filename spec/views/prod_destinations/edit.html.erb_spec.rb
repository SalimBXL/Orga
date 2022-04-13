require 'rails_helper'

RSpec.describe "prod_destinations/edit", type: :view do
  before(:each) do
    @prod_destination = assign(:prod_destination, ProdDestination.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit prod_destination form" do
    render

    assert_select "form[action=?][method=?]", prod_destination_path(@prod_destination), "post" do

      assert_select "input[name=?]", "prod_destination[name]"
    end
  end
end
