require 'rails_helper'

RSpec.describe Absence, type: :model do
  let(:absence) { FactoryBot.build(:absence) }
  
  it "can be instanciated" do
    expect(absence).not_to be nil
  end

  it "can be saved" do
    expect(absence.save).to be true
  end
end
