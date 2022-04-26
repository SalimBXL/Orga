require 'rails_helper'

RSpec.describe "maintenances/show", type: :view do
  before(:each) do
    @maintenance = assign(:maintenance, Maintenance.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
