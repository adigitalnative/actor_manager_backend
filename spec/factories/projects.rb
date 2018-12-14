FactoryBot.define do
  factory :project do
    name { "MyString" }
    company { nil }
    user { FactoryBot.build_stubbed(:user) }
  end
end
