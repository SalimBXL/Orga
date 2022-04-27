require 'rails_helper'

RSpec.describe "maintenance_ressources/show", type: :view do
  before(:each) do
    @maintenance_ressource = assign(:maintenance_ressource, MaintenanceRessource.create!(
      :name => "Name",
      :service => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
