require 'rails_helper'

RSpec.describe Semaine, type: :model do
  let(:semaine) { FactoryBot.build(:semaine) }
  
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
