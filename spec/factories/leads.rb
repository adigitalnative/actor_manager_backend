FactoryBot.define do
  factory :lead do
    opportunity { FactoryBot.build_stubbed(:opportunity) }
    user { FactoryBot.build_stubbed(:user) }
    new { true }
    archived { false }
  end
end
