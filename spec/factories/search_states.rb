FactoryBot.define do
  factory :search_state do
    user { FactoryBot.build_stubbed(:user) }
    state { FactoryBot.build_stubbed(:state) }
  end
end
