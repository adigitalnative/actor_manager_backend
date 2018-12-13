require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.build_stubbed(:category) }

  it "is valid with valid attributes" do
    expect(category).to be_valid
  end

  it "is invalid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "has auditions" do
    expect(category).to respond_to(:auditions)
  end
end
