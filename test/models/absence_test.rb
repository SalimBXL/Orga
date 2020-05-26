require 'test_helper'
 
class AbsenceTest < ActiveSupport::TestCase

  test "should not validate without required agruments" do
    absence = Absence.new
    assert_not absence.save, "Saved without required arguments"
  end

  test "should not correctly validate without date" do
    absence = Absence.new
    #absence.date = Date.today
    #absence.date_fin = absence.date + 5.days
    absence.type_absence = TypeAbsence.new(nom: "test")
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    absence.utilisateur = utilisateur
    assert_not absence.save, "Saved without a date"
  end

  test "should not correctly validate without type_absence" do
    absence = Absence.new
    absence.date = Date.today
    absence.date_fin = absence.date + 5.days
    #absence.type_absence = TypeAbsence.new(nom: "test")
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    absence.utilisateur = utilisateur
    assert_not absence.save, "Saved without a typr_absence"
  end

  test "should not correctly validate without utilisateur" do
    absence = Absence.new
    absence.date = Date.today
    absence.date_fin = absence.date + 5.days
    absence.type_absence = TypeAbsence.new(nom: "test")
    #groupe = Groupe.new(nom: "nom")
    #service = Service.new(nom: "nom")
    #utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    #absence.utilisateur = utilisateur
    assert_not absence.save, "Saved without utilisateur"
  end

  
  test "should correctly validate with required arguments" do
    absence = Absence.new
    absence.date = Date.today
    absence.date_fin = absence.date + 5.days
    absence.type_absence = TypeAbsence.new(nom: "test")
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    absence.utilisateur = utilisateur
    assert absence.save
  end
end