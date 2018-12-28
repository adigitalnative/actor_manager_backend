require 'rails_helper'

RSpec.describe State, type: :model do
  let(:stubbed_state) { FactoryBot.build_stubbed(:state, name: "HA") }

  it "is valid with valid inputs" do
    expect(stubbed_state).to be_valid
  end

  it "is invalid without a name" do
    stubbed_state.name = nil
    expect(stubbed_state).to_not be_valid
  end

  it "is invalid with a duplicate name" do
    FactoryBot.create(:state, name: "HA")
    expect(stubbed_state).to_not be_valid
  end
end
