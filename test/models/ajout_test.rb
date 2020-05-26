require 'test_helper'
 
class AjoutTest < ActiveSupport::TestCase

  test "should not validate without required agruments" do
    ajout = Ajout.new
    assert_not ajout.save, "Saved without required arguments"
  end

  test "Should not validate without utilisateur" do 
    ajout = Ajout.new
    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    
    #ajout.utilisateur = utilisateur
    ajout.date = Date.today
    ajout.am_pm = false
    ajout.work1 = work
    ajout.work2 = work
    ajout.work3 = work

    assert_not ajout.save, "Saved without utilisateur"
  end

  test "Should not validate without date" do 
    ajout = Ajout.new
    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    
    ajout.utilisateur = utilisateur
    #ajout.date = Date.today
    ajout.am_pm = false
    ajout.work1 = work
    ajout.work2 = work
    ajout.work3 = work

    assert_not ajout.save, "Saved without date"
  end
  
  test "should correctly validate with required arguments" do
    ajout = Ajout.new

    groupe = Groupe.new(nom: "test")
    classe = Classe.new(nom: "test")
    lieu = Lieu.new(nom: "nom")
    service = Service.new(nom: "nom", lieu: lieu)
    utilisateur = Utilisateur.new(nom: "nom", prenom: "prenom", email: "test@test.com", groupe: groupe, service: service)
    work = Work.new(nom: "nom test", code: "code", service: service, groupe: groupe, classe: classe)
    
    ajout.utilisateur = utilisateur
    ajout.date = Date.today
    ajout.am_pm = false
    ajout.work1 = work
    ajout.work2 = work
    ajout.work3 = work

    assert ajout.save
  end
end