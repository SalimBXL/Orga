require 'test_helper'
 
class FermetureTest < ActiveSupport::TestCase

  test "should not validate without required arguments" do
    fermeture = Fermeture.new
    assert_not fermeture.save, "Saved without required arguments"
  end

  test "should not validate without a name" do
    fermeture = Fermeture.new
    #fermeture.nom = "nom test"
    fermeture.date = Date.today
    fermeture.date_fin = fermeture.date + 5.days
    lieu = Lieu.new(nom: "nom")
    fermeture.service = Service.new(nom: "nom", lieu: lieu)
    assert_not fermeture.save, "Saved without a name"
  end
  
  test "should not validate without a date" do
    fermeture = Fermeture.new
    fermeture.nom = "nom test"
    #fermeture.date = Date.today
    #fermeture.date_fin = fermeture.date + 5.days
    lieu = Lieu.new(nom: "nom")
    fermeture.service = Service.new(nom: "nom", lieu: lieu)
    assert_not fermeture.save, "Saved without a date"
  end

  test "should not validate without a service" do
    fermeture = Fermeture.new
    fermeture.nom = "nom test"
    fermeture.date = Date.today
    fermeture.date_fin = fermeture.date + 5.days
    lieu = Lieu.new(nom: "nom")
    #fermeture.service = Service.new(nom: "nom", lieu: lieu)
    assert_not fermeture.save, "Saved without a service"
  end

  test "should correctly validate with required arguments" do
    fermeture = Fermeture.new
    fermeture.nom = "nom test"
    fermeture.date = Date.today
    fermeture.date_fin = fermeture.date + 5.days
    lieu = Lieu.new(nom: "nom")
    fermeture.service = Service.new(nom: "nom", lieu: lieu)
    assert fermeture.save
  end
end