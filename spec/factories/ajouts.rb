FactoryBot.define do
    factory :ajout do
      date { Date.today }
      utilisateur
      work1 { rand(10) }
    end
  end
  