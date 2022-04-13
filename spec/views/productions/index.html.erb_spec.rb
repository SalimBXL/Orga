require 'rails_helper'

RSpec.describe "productions/index", type: :view do
  before(:each) do
    assign(:productions, [
      Production.create!(
        :traceur => nil,
        :quantity => 2.5,
        :prod_unit => nil,
        :prod_destination => nil,
        :service => nil,
        :utilisateur => nil
      ),
      Production.create!(
        :traceur => nil,
        :quantity => 2.5,
        :prod_unit => nil,
        :prod_destination => nil,
        :service => nil,
        :utilisateur => nil
      )
    ])
  end

  it "renders a list of productions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
