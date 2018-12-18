FactoryBot.define do
  factory :book_item do
    title { "MyString" }
    role { "MyString" }
    user { FactoryBot.build_stubbed(:user) }
    author { Faker::HarryPotter.character }
  end
end
