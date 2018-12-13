FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
  end
end
