FactoryBot.define do
  factory :work do
    nom { Faker::Job.title }
    description { Faker::Lorem.sentence }
    groupe
  end
end
