FactoryBot.define do
  factory :book_item do
    title { "MyString" }
    role { "MyString" }
    user { FactoryBot.build_stubbed(:user) }
  end
end
