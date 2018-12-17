require 'rails_helper'

RSpec.describe Result, type: :model do
  let (:result) { FactoryBot.build_stubbed(:result) }

  it "is valid with valid inputs" do
    expect(result).to be_valid
  end

  it "is invalid without a name" do
    result.name = nil
    expect(result).to_not be_valid
  end

  it "has reports" do
    expect(result).to respond_to(:reports)
  end
end
