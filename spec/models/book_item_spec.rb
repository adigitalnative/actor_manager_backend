require 'rails_helper'

RSpec.describe BookItem, type: :model do
  let(:book_item) { FactoryBot.build_stubbed(:book_item) }

  it "is valid with valid attributes" do
    expect(book_item).to be_valid
  end

  it "is invalid without a title" do
    book_item.title = nil
    expect(book_item).to_not be_valid
  end

  it "is invalid without a user_id" do
    book_item.user_id = nil
    expect(book_item).to_not be_valid
  end

  it "can belong to many auditions" do
    expect(book_item).to respond_to(:auditions)
  end
end
