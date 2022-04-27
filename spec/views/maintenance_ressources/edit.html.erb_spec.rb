require 'rails_helper'

RSpec.describe "maintenance_ressources/edit", type: :view do
  before(:each) do
    @maintenance_ressource = assign(:maintenance_ressource, MaintenanceRessource.create!(
      :name => "MyString",
      :service => nil
    ))
  end

  it "renders the edit maintenance_ressource form" do
    render

    assert_select "form[action=?][method=?]", maintenance_ressource_path(@maintenance_ressource), "post" do

      assert_select "input[name=?]", "maintenance_ressource[name]"

      assert_select "input[name=?]", "maintenance_ressource[service_id]"
    end
  end
end
