require 'rails_helper'

RSpec.describe "productions/edit", type: :view do
  before(:each) do
    @production = assign(:production, Production.create!(
      :traceur => nil,
      :quantity => 1.5,
      :prod_unit => nil,
      :prod_destination => nil,
      :service => nil,
      :utilisateur => nil
    ))
  end

  it "renders the edit production form" do
    render

    assert_select "form[action=?][method=?]", production_path(@production), "post" do

      assert_select "input[name=?]", "production[traceur_id]"

      assert_select "input[name=?]", "production[quantity]"

      assert_select "input[name=?]", "production[prod_unit_id]"

      assert_select "input[name=?]", "production[prod_destination_id]"

      assert_select "input[name=?]", "production[service_id]"

      assert_select "input[name=?]", "production[utilisateur_id]"
    end
  end
end
