require 'test_helper'
 
class JourTest < ActiveSupport::TestCase

  test "should not validate without required agruments" do
    jour = Jour.new
    assert_not jour.save, "Saved without required arguments"
  end

  test "Should not validate without utilisateur" do
    jour = Jour.new
    #groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    #utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    #jour.utilisateur = utilisateur
    jour.service = service
    jour.am_pm = 1
    jour.date = Date.today
    assert_not jour.save, "Saved without utilisateur"
  end

  test "Should not validate without service" do
    jour = Jour.new
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    jour.utilisateur = utilisateur
    #jour.service = service
    jour.am_pm = 1
    jour.date = Date.today
    assert_not jour.save, "Saved without service"
  end

  test "Should not validate without date" do
    jour = Jour.new
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    jour.utilisateur = utilisateur
    jour.service = service
    jour.am_pm = 1
    #jour.date = Date.today
    assert_not jour.save, "Saved without date"
  end

  test "Should not validate without am_pm" do
    jour = Jour.new
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    jour.utilisateur = utilisateur
    jour.service = service
    #jour.am_pm = 1
    jour.date = Date.today
    assert_not jour.save, "Saved without am_pm"
  end

  test "should correctly validate with required arguments" do
    jour = Jour.new
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    jour.utilisateur = utilisateur
    jour.service = service
    jour.am_pm = 1
    jour.date = Date.today
    assert jour.save
  end
end