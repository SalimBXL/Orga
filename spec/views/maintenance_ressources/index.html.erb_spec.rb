require 'rails_helper'

RSpec.describe "maintenance_ressources/index", type: :view do
  before(:each) do
    assign(:maintenance_ressources, [
      MaintenanceRessource.create!(
        :name => "Name",
        :service => nil
      ),
      MaintenanceRessource.create!(
        :name => "Name",
        :service => nil
      )
    ])
  end

  it "renders a list of maintenance_ressources" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
