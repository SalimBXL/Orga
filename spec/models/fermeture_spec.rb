require 'rails_helper'

RSpec.describe Fermeture, type: :model do
  let(:fermeture) { FactoryBot.build(:fermeture) }
  
  it "can be instanciated" do
    expect(fermeture).not_to be nil
  end

  it "can be saved" do
    expect(fermeture.save).to be true
  end
end
