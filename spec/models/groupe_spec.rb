require 'rails_helper'

RSpec.describe Groupe, type: :model do
  let(:groupe) { FactoryBot.build(:groupe) }
  
  it "can be instanciated" do 
    expect(groupe).not_to be nil 
  end

  it "can be saved" do
    expect(groupe.save).to be true
  end

  

end
