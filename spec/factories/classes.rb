FactoryBot.define do
  factory :classe do
    nom { Faker::Team.creature }
    description { Faker::Lorem.sentence }
  end
end
