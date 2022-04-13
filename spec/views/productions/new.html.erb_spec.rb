require 'rails_helper'

RSpec.describe "productions/new", type: :view do
  before(:each) do
    assign(:production, Production.new(
      :traceur => nil,
      :quantity => 1.5,
      :prod_unit => nil,
      :prod_destination => nil,
      :service => nil,
      :utilisateur => nil
    ))
  end

  it "renders new production form" do
    render

    assert_select "form[action=?][method=?]", productions_path, "post" do

      assert_select "input[name=?]", "production[traceur_id]"

      assert_select "input[name=?]", "production[quantity]"

      assert_select "input[name=?]", "production[prod_unit_id]"

      assert_select "input[name=?]", "production[prod_destination_id]"

      assert_select "input[name=?]", "production[service_id]"

      assert_select "input[name=?]", "production[utilisateur_id]"
    end
  end
end
