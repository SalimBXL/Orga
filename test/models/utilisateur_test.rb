require 'test_helper'
 
class UtilisateurTest < ActiveSupport::TestCase

  test "should not validate without required agruments" do
    utilisateur = Utilisateur.new
    assert_not utilisateur.save, "Saved without required arguments"
  end

  test "should not correctly validate without nom" do
    utilisateur = Utilisateur.new
    utilisateur.groupe = Groupe.new(nom: "nom")
    utilisateur.service = Service.new(nom: "nom")
    #utilisateur.nom = "nom"
    utilisateur.prenom = "prenom"
    utilisateur.email = "test@test.com"
    assert_not utilisateur.save, "Saved without nom"
  end

  test "should not correctly validate without prenom" do
    utilisateur = Utilisateur.new
    utilisateur.groupe = Groupe.new(nom: "nom")
    utilisateur.service = Service.new(nom: "nom")
    utilisateur.nom = "nom"
    #utilisateur.prenom = "prenom"
    utilisateur.email = "test@test.com"
    assert_not utilisateur.save, "Saved without a prenom"
  end

  test "should not correctly validate without groupe" do
    utilisateur = Utilisateur.new
    #utilisateur.groupe = Groupe.new(nom: "nom")
    utilisateur.service = Service.new(nom: "nom")
    utilisateur.nom = "nom"
    utilisateur.prenom = "prenom"
    utilisateur.email = "test@test.com"
    assert_not utilisateur.save, "Saved without groupe"
  end

  test "should not correctly validate without service" do
    utilisateur = Utilisateur.new
    utilisateur.groupe = Groupe.new(nom: "nom")
    #utilisateur.service = Service.new(nom: "nom")
    utilisateur.nom = "nom"
    utilisateur.prenom = "prenom"
    utilisateur.email = "test@test.com"
    assert_not utilisateur.save, "Saved without service"
  end

  test "should not correctly validate without email" do
    utilisateur = Utilisateur.new
    utilisateur.groupe = Groupe.new(nom: "nom")
    utilisateur.service = Service.new(nom: "nom")
    utilisateur.nom = "nom"
    utilisateur.prenom = "prenom"
    #utilisateur.email = "test@test.com"
    assert_not utilisateur.save, "Saved without email"
  end
  
  test "should correctly validate with required arguments" do
    utilisateur = Utilisateur.new
    utilisateur.groupe = Groupe.new(nom: "nom")
    utilisateur.service = Service.new(nom: "nom")
    utilisateur.nom = "nom"
    utilisateur.prenom = "prenom"
    utilisateur.email = "test@test.com"
    assert utilisateur.save
  end
end