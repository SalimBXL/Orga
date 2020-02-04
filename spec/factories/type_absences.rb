FactoryBot.define do
  factory :type_absence do
    nom { Faker::Verb.ing_form }
    code { Faker::CryptoCoin.acronym }
    description { Faker::Lorem.sentence }
  end
end
