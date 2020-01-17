require 'rails_helper'

RSpec.describe Semaine, type: :model do
  let(:semaine) { FactoryBot.build(:semaine) }
  
  it "can be instanciated" do
    expect(semaine).not_to be nil
  end

  it "can be saved" do
    expect(semaine.save).to be true
  end
end
