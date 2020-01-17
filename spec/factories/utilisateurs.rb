FactoryBot.define do
  factory :utilisateur do
    prenom { Faker::Name.first_name }
    nom { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    gsm { Faker::PhoneNumber.cell_phone_with_country_code }
  end
end
