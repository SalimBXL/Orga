require 'rails_helper'

RSpec.describe "traceurs/new", type: :view do
  before(:each) do
    assign(:traceur, Traceur.new(
      :code => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new traceur form" do
    render

    assert_select "form[action=?][method=?]", traceurs_path, "post" do

      assert_select "input[name=?]", "traceur[code]"

      assert_select "input[name=?]", "traceur[name]"
    end
  end
end
