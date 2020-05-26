require 'test_helper'
 
class ClasseTest < ActiveSupport::TestCase

  test "should not validate wthout a name" do
    classe = Classe.new
    assert_not classe.save, "Saved without a name"
  end

  
  test "should correctly validate with a name" do
    classe = Classe.new
    classe.nom = "nom test"
    assert classe.save
  end
end