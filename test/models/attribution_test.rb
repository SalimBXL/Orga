require 'test_helper'
 
class WorkingListTest < ActiveSupport::TestCase

  test "should not validate without required agruments" do
    workingList = WorkingList.new
    assert_not workingList.save, "Saved without required arguments"
  end

  test "should not validate without jour" do
    workingList = WorkingList.new
    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    jour = Jour.new(utilisateur: utilisateur, service: service, am_pm: 1, date: Date.today)

    #workingList.jour = jour
    workingList.work = work
    assert_not workingList.save, "Saved without jour"
  end

  test "should not validate without work" do
    workingList = WorkingList.new
    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    jour = Jour.new(utilisateur: utilisateur, service: service, am_pm: 1, date: Date.today)

    workingList.jour = jour
    #workingList.work = work
    assert_not workingList.save, "Saved without work"
  end

  test "should correctly validate with required arguments" do
    workingList = WorkingList.new
    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    jour = Jour.new(utilisateur: utilisateur, service: service, am_pm: 1, date: Date.today)

    workingList.jour = jour
    workingList.work = work

    assert workingList.save
  end
end