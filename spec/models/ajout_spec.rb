require 'rails_helper'

RSpec.describe Ajout, type: :model do
    let(:ajout) { FactoryBot.build(:ajout) }

    it "can be instancied" do
        expect(ajout).not_to be nil
    end

    it "can be save" do
        expect(ajout.save).to be true
    end

end