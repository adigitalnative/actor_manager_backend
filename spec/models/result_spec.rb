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

  it "does not have reports" do
    expect(result).to_not respond_to(:reports)
  end

  it "has projects" do

    expect(result).to respond_to(:projects)
  end

  it "is invalid without a booked boolean" do
    result.booked = nil
    expect(result).to_not be_valid
  end
end
