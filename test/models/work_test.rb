require 'test_helper'
 
class WorkTest < ActiveSupport::TestCase

  test "should not validate without required arguments" do
    work = Work.new
    assert_not work.save, "Saved without required arguments"
  end

  test "should not validate without a name" do
    work = Work.new
    #work.nom = "nom test"
    work.code = "code"
    lieu = Lieu.new(nom: "nom")
    work.service = Service.new(nom: "nom", lieu: lieu)
    work.groupe = Groupe.new(nom: "test")
    work.classe = Classe.new(nom: "test")
    assert_not work.save, "Saved without a name"
  end
  
  test "should not validate without a Service" do
    work = Work.new
    work.nom = "nom test"
    work.code = "code"
    lieu = Lieu.new(nom: "nom")
    #work.service = Service.new(nom: "nom", lieu: lieu)
    work.groupe = Groupe.new(nom: "test")
    work.classe = Classe.new(nom: "test")
    assert_not work.save, "Saved without a service"
  end

  test "should not validate without a groupe" do
    work = Work.new
    work.nom = "nom test"
    work.code = "code"
    lieu = Lieu.new(nom: "nom")
    work.service = Service.new(nom: "nom", lieu: lieu)
    #work.groupe = Groupe.new(nom: "test")
    work.classe = Classe.new(nom: "test")
    assert_not work.save, "Saved without a groupe"
  end

  test "should not validate without a classe" do
    work = Work.new
    work.nom = "nom test"
    work.code = "code"
    lieu = Lieu.new(nom: "nom")
    work.service = Service.new(nom: "nom", lieu: lieu)
    work.groupe = Groupe.new(nom: "test")
    #work.classe = Classe.new(nom: "test")
    assert_not work.save, "Saved without a classe"
  end

  test "should not validate without a code" do
    work = Work.new
    work.nom = "nom test"
    #work.code = "code"
    lieu = Lieu.new(nom: "nom")
    work.service = Service.new(nom: "nom", lieu: lieu)
    work.groupe = Groupe.new(nom: "test")
    work.classe = Classe.new(nom: "test")
    assert_not work.save, "Saved without a code"
  end

  test "should correctly validate with required arguments" do
    work = Work.new
    work.nom = "nom test"
    work.code = "code"
    lieu = Lieu.new(nom: "nom")
    work.service = Service.new(nom: "nom", lieu: lieu)
    work.groupe = Groupe.new(nom: "test")
    work.classe = Classe.new(nom: "test")
    assert work.save
  end
end