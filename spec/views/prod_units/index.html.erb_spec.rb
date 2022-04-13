require 'rails_helper'

RSpec.describe "prod_units/index", type: :view do
  before(:each) do
    assign(:prod_units, [
      ProdUnit.create!(
        :name => "Name"
      ),
      ProdUnit.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of prod_units" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
