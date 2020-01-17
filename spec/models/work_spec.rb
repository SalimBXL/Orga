require 'rails_helper'

RSpec.describe Work, type: :model do
  let(:work) { FactoryBot.build(:work) }
  
  it "can be instanciated" do
    expect(work).not_to be nil
  end

  it "can be saved" do
    expect(work.save).to be true
  end
end
