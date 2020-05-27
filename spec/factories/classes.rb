FactoryBot.define do
  factory :classe do
    nom { Faker::Job.field }
    description { Faker::Lorem.sentence }
  end
end
