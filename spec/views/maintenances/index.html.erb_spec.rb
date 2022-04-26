require 'rails_helper'

RSpec.describe "maintenances/index", type: :view do
  before(:each) do
    assign(:maintenances, [
      Maintenance.create!(
        :name => "Name"
      ),
      Maintenance.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of maintenances" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
