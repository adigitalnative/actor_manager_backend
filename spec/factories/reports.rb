FactoryBot.define do
  factory :report do
    pre { "MyText" }
    in_room { "MyText" }
    post { "MyText" }
    audition { nil }
  end
end
