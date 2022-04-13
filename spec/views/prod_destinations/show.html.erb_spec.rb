require 'rails_helper'

RSpec.describe "prod_destinations/show", type: :view do
  before(:each) do
    @prod_destination = assign(:prod_destination, ProdDestination.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
