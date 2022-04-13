require 'rails_helper'

RSpec.describe "prod_destinations/index", type: :view do
  before(:each) do
    assign(:prod_destinations, [
      ProdDestination.create!(
        :name => "Name"
      ),
      ProdDestination.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of prod_destinations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
