require 'rails_helper'

RSpec.describe "maintenance_ressources/new", type: :view do
  before(:each) do
    assign(:maintenance_ressource, MaintenanceRessource.new(
      :name => "MyString",
      :service => nil
    ))
  end

  it "renders new maintenance_ressource form" do
    render

    assert_select "form[action=?][method=?]", maintenance_ressources_path, "post" do

      assert_select "input[name=?]", "maintenance_ressource[name]"

      assert_select "input[name=?]", "maintenance_ressource[service_id]"
    end
  end
end
