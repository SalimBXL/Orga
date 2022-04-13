require 'rails_helper'

RSpec.describe "traceurs/index", type: :view do
  before(:each) do
    assign(:traceurs, [
      Traceur.create!(
        :code => "Code",
        :name => "Name"
      ),
      Traceur.create!(
        :code => "Code",
        :name => "Name"
      )
    ])
  end

  it "renders a list of traceurs" do
    render
    assert_select "tr>td", :text => "Code".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
