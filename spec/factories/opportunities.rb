FactoryBot.define do
  factory :opportunity do
    source { "MyString" }
    title { "MyString" }
    company { "MyString" }
    url { "MyString" }
    state { FactoryBot.build_stubbed(:state) }
    active { true }
  end
end
