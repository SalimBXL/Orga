require 'rails_helper'

RSpec.describe Semaine, type: :model do
  let(:semaine) { FactoryBot.build(:semaine) }
  
  describe "validations" do
    it "can be instanciated" do
      expect(semaine).not_to be nil
    end

    it "can be saved" do
      expect(semaine.save).to be true
    end
    
    it "doit être unique dans la base" do
      semaine2 = FactoryBot.build(:semaine)
      semaine2.numero_semaine = semaine.numero_semaine
      semaine2.utilisateur_id = semaine.utilisateur_id
      expect((semaine.numero_semaine!=semaine2.numero_semaine) && (semaine.utilisateur_id!=semaine2.utilisateur_id)).to be false
    end
  end
  
  describe "Slug" do
    it "sets the slug on validation" do
      nom_u = "#{semaine.utilisateur.prenom} #{semaine.utilisateur.nom}"
      slugify = "#{nom_u} #{semaine.numero_semaine}".parameterize
      expect { semaine.valid? }.to change { semaine.slug }.from(nil).to(slugify)
    end

    it "Slug est unique dans la base" do
      expect(Semaine.where(slug: semaine.slug).count<2).to be true
    end
  end


end
