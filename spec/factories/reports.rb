FactoryBot.define do
  factory :report do
    audition { nil }
    result { nil }
    notes { "MyText" }
    people { "MyText" }
    auditors { "MyText" }
  end
end
