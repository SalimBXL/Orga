require 'rails_helper'

RSpec.describe "prod_units/edit", type: :view do
  before(:each) do
    @prod_unit = assign(:prod_unit, ProdUnit.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit prod_unit form" do
    render

    assert_select "form[action=?][method=?]", prod_unit_path(@prod_unit), "post" do

      assert_select "input[name=?]", "prod_unit[name]"
    end
  end
end
