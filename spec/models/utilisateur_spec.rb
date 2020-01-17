require 'rails_helper'

RSpec.describe Utilisateur, type: :model do
  let(:utilisateur) { FactoryBot.build(:utilisateur) }
  
  it "can be instanciated" do
    expect(utilisateur).not_to be nil
  end

  it "can be saved" do
    expect(utilisateur.save).to be true
  end
end
