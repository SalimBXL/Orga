require 'rails_helper'

RSpec.describe Lieu, type: :model do
  let(:lieu) { FactoryBot.build(:lieu) }
  
  it "can be instanciated" do
    expect(lieu).not_to be nil
  end

  it "can be saved" do
    expect(lieu.save).to be true
  end
end
