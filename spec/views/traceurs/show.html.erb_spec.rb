require 'rails_helper'

RSpec.describe "traceurs/show", type: :view do
  before(:each) do
    @traceur = assign(:traceur, Traceur.create!(
      :code => "Code",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name/)
  end
end
