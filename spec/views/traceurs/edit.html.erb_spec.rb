require 'rails_helper'

RSpec.describe "traceurs/edit", type: :view do
  before(:each) do
    @traceur = assign(:traceur, Traceur.create!(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit traceur form" do
    render

    assert_select "form[action=?][method=?]", traceur_path(@traceur), "post" do

      assert_select "input[name=?]", "traceur[code]"

      assert_select "input[name=?]", "traceur[name]"
    end
  end
end
