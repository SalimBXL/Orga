FactoryBot.define do
  factory :production do
    traceur { nil }
    quantity { 1.5 }
    prod_unit { nil }
    prod_destination { nil }
    service { nil }
    utilisateur { nil }
  end
end
