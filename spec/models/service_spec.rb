require 'rails_helper'

RSpec.describe Service, type: :model do
  let(:service) { FactoryBot.build(:service) }
  
  it "can be instanciated" do
    expect(service).not_to be nil
  end

  it "can be saved" do
    expect(service.save).to be true
  end
end
