FactoryBot.define do
    factory :ajout do
      date { Date.today }
      utilisateur
      work1 { FactoryBot.build(:work) }
    end
  end
  