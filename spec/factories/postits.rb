FactoryBot.define do
  factory :postit do
    title { "MyString" }
    body { "MyText" }
    level { 1 }
    is_private { false }
  end
end
