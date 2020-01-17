require 'rails_helper'

RSpec.describe Conge, type: :model do
  let(:conge) { FactoryBot.build(:conge) }
  
  it "can be instanciated" do
    expect(conge).not_to be nil
  end

  it "can be saved" do
    expect(conge.save).to be true
  end
end
