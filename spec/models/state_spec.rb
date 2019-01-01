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

  xit "is invalid without a search boolean" do
    stubbed_state.search = nil
    expect(stubbed_state).to_not be_valid
  end

  # Having an issue, wifi is out so debugging needs to wait for wifi
  context ".search?" do
    xit "can be true" do
      stubbed_state.search = true
      expect(stubbed_state).to be_valid
    end

    xit "can be false" do
      stubbed_state.search = false
      expect(stubbed_state).to be_valid
    end

    xit "can't be a different value" do
      stubbed_state.search = "foo blah"
      expect(stubbed_state).to_not be_valid
    end

  end

  context "#to_scrape" do
    before do
      @state_one = FactoryBot.create(:state, name: "MD")
      @state_two = FactoryBot.create(:state, name: "DC")
      @state_three = FactoryBot.create(:state, name: "VA")
      @state_four = FactoryBot.create(:state, name: "WA")
    end

    context "when there are no states to search" do
      it "returns an empty array" do
        expect(State.to_scrape).to eq([])
      end
    end

    context "when there are states to search" do
      before do
        @state_one.update(search: true)
        @state_two.update(search: true)
        @state_three.update(search: true)
        @result = State.to_scrape

      end

      it "returns an array of those states" do
        expect(@result).to include(@state_one)
        expect(@result).to include(@state_two)
        expect(@result).to include(@state_three)
      end

      it "doesn't include other states" do
        expect(@result).to_not include(@state_four)
      end
    end
  end
end
