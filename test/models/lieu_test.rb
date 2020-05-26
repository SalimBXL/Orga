require 'test_helper'
 
class LieuTest < ActiveSupport::TestCase

  test "should not validate wthout a name" do
    lieu = Lieu.new
    assert_not lieu.save, "Saved without a name"
  end

  
  test "should correctly validate with a name" do
    lieu = Lieu.new
    lieu.nom = "nom test"
    assert lieu.save
  end
end