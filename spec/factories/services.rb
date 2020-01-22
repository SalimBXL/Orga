FactoryBot.define do
  factory :service do
    nom { Faker::Company.name }
    description { Faker::Lorem.sentence }
    lieu
  end
end
