require 'rails_helper'

RSpec.describe Jour, type: :model do
  let(:jour) { FactoryBot.build(:jour) }
  
  it "can be instanciated" do
    expect(jour).not_to be nil
  end

  it "can be saved" do
    expect(jour.save).to be true
  end
end
