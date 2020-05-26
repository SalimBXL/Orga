require 'test_helper'
 
class ServiceTest < ActiveSupport::TestCase

  test "should not validate wthout required arguments" do
    service = Service.new
    assert_not service.save, "Saved without required argument"
  end

  test "should not validate wthout name" do
    service = Service.new
    service.lieu = Lieu.new(nom: "test")
    assert_not service.save, "Saved without a name"
  end

  test "should not validate without Lieu" do
    service = Service.new
    service.nom = "nom test"
    assert_not service.save, "Saved without a Lieu"
  end
  
  test "should correctly validate with required arguments" do
    service = Service.new
    service.nom = "nom test"
    service.lieu = Lieu.new(nom: "test")
    assert service.save
  end
end