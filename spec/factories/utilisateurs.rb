FactoryBot.define do
  factory :utilisateur do
    prenom { Faker::Name.first_name }
    nom { Faker::Name.last_name }
    date_de_naissance { Faker::Date.birthday(min_age: 18, max_age: 65) }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number_with_country_code }
    gsm { Faker::PhoneNumber.cell_phone_with_country_code }
    groupe
    service
  end
end
