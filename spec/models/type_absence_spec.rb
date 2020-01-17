require 'rails_helper'

RSpec.describe TypeAbsence, type: :model do
  let(:type_absence) { FactoryBot.build(:type_absence) }
  
  it "can be instanciated" do
    expect(type_absence).not_to be nil
  end

  it "can be saved" do
    expect(type_absence.save).to be true
  end
end
