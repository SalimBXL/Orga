FactoryBot.define do
  factory :groupe do
    nom { Faker::Job.field }
    description { Faker::Lorem.sentence }
  end
end
