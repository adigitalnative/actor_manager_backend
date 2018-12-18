FactoryBot.define do
  factory :audition_piece do
    book_item { FactoryBot.build_stubbed(:book_item) }
    audition { FactoryBot.build_stubbed(:audition) }
  end
end
