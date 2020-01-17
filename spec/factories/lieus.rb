FactoryBot.define do
  factory :lieu do
    nom { Faker::Bank.name }
    adresse { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    Note { Faker::Lorem.sentence }
  end
end
