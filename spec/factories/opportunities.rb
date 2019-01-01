FactoryBot.define do
  factory :opportunity do
    source { "MyString" }
    title { "MyString" }
    company { FactoryBot.build_stubbed(:company) }
    url { "MyString" }
    state { FactoryBot.build_stubbed(:state) }
  end
end
