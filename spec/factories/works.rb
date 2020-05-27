FactoryBot.define do
  factory :work do
    nom { Faker::Job.title }
    description { Faker::Lorem.sentence }
    code { Faker::CryptoCoin.acronym }
    groupe
    classe
    service
  end
end
