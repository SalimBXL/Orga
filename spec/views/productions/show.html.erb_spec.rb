require 'rails_helper'

RSpec.describe "productions/show", type: :view do
  before(:each) do
    @production = assign(:production, Production.create!(
      :traceur => nil,
      :quantity => 2.5,
      :prod_unit => nil,
      :prod_destination => nil,
      :service => nil,
      :utilisateur => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
