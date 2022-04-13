require 'rails_helper'

RSpec.describe "prod_units/show", type: :view do
  before(:each) do
    @prod_unit = assign(:prod_unit, ProdUnit.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
