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

  test "should set same as date if date_fin is empty" do
    absence = Absence.new
    absence.date = Date.today
    #absence.date_fin = absence.date + 5.days
    absence.type_absence = TypeAbsence.new(nom: "test")
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    absence.utilisateur = utilisateur
    #assert_not absence.save, "Saved without a date"
    absence.valid?
    assert_equal absence.date, absence.date_fin, "When not specified, Date_Fin (#{absence.date_fin}) must be equal to date (#{absence.date})"
  end

  test "should have date_fin later than date" do
    absence = Absence.new
    absence.date = Date.today
    absence.date_fin = absence.date + 5.days
    delta = (absence.date_fin.to_date - absence.date.to_date).to_i
    absence.type_absence = TypeAbsence.new(nom: "test")
    groupe = Groupe.new(nom: "nom")
    service = Service.new(nom: "nom")
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    absence.utilisateur = utilisateur
    #assert_not absence.save, "Saved without a date"
    #assert_equal absence.date, absence.date_fin, "When not specified, Date_Fin is equal to Date"
    #assert_difference absence.date_fin-absence.date, difference >= 0, message = "Date_fin must be later than Date"
    assert_not delta < 0, "Date_fin must be later than Date"
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