require 'rails_helper'

RSpec.describe SearchState, type: :model do
  let(:search_state) { FactoryBot.build_stubbed(:search_state)}

  it "is valid with valid attributes" do
    expect(search_state).to be_valid
  end

  it "is invalid without a state" do
    search_state.state_id = nil
    expect(search_state).to_not be_valid
  end

  it "is invalid without a user" do
    search_state.user_id = nil
    expect(search_state).to_not be_valid
  end
end
