require 'rails_helper'

RSpec.describe Classe, type: :model do
  let(:classe) { FactoryBot.build(:classe) }
  
  it "can be instanciated" do 
    expect(classe).not_to be nil 
  end

  it "can be saved" do
    expect(classe.save).to be true
  end

end
