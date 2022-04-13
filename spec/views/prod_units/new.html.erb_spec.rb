require 'rails_helper'

RSpec.describe "prod_units/new", type: :view do
  before(:each) do
    assign(:prod_unit, ProdUnit.new(
      :name => "MyString"
    ))
  end

  it "renders new prod_unit form" do
    render

    assert_select "form[action=?][method=?]", prod_units_path, "post" do

      assert_select "input[name=?]", "prod_unit[name]"
    end
  end
end
