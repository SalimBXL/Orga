require 'test_helper'
 
class GroupeTest < ActiveSupport::TestCase

  test "should not validate wthout a name" do
    groupe = Groupe.new
    assert_not groupe.save, "Saved the groupe without a groupe name"
  end

  
  test "should correctly validate with a name" do
    groupe = Groupe.new
    groupe.nom = "nom test"
    assert groupe.save
  end
end