FactoryBot.define do
  factory :company do
    name { "MyString" }
    user { FactoryBot.build_stubbed(:user) }
  end
end
