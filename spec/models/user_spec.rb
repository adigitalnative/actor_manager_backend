require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build_stubbed(:user) }

  it "is valid with valid inputs" do
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is invalid without a password_digest" do
    user.password_digest = nil
    expect(user).to_not be_valid
  end

  it "is invalid if the email is not unique" do
    FactoryBot.create(:user, email: "jane@dog.com")
    user.email = "jane@dog.com"
    expect(user).to_not be_valid
  end

  it "is invalid without a first_name" do
    user.first_name = nil
    expect(user).to_not be_valid
  end

  it "is invalid without a last_name" do
    user.last_name = nil
    expect(user).to_not be_valid
  end

  it "has many projects" do
    expect(user).to respond_to(:projects)
  end

  it "has many companies" do
    expect(user).to respond_to(:companies)
  end

  it "has many book_items" do
    expect(user).to respond_to(:book_items)
  end

  it "can report it's percent of booked projects" do
    expect(user).to respond_to(:percent_booked)
  end

  it "can report it's percent of reported projects" do
    expect(user).to respond_to(:percent_reported)
  end

  it "can report how many projects are waiting for a response" do
    expect(user).to respond_to(:potential_bookings)
  end

  it "can have many states" do
    expect(user).to respond_to(:states)
  end

end
