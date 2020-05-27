FactoryBot.define do
  factory :groupe do
    nom { Faker::Team.name }
    description { Faker::Lorem.sentence }
  end
end
