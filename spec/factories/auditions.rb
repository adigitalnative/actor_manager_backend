FactoryBot.define do
  factory :audition do
    bring { "MyText" }
    prepare { "MyText" }
    project { FactoryBot.build_stubbed(:project) }
    category { FactoryBot.build_stubbed(:category) }
    user { FactoryBot.build_stubbed(:user) }
  end
end
