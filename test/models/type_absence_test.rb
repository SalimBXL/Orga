require 'test_helper'
 
class TypeAbsenceTest < ActiveSupport::TestCase

  test "should not validate wthout a name" do
    typeAbsence = TypeAbsence.new
    assert_not typeAbsence.save, "Saved without a name neither a code"
  end

  
  test "should correctly validate with a name and a code" do
    typeAbsence = TypeAbsence.new
    typeAbsence.nom = "nom test"
    typeAbsence.code = "code"
    assert typeAbsence.save
  end
end