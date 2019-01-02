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

  it "has users" do
    expect(stubbed_state).to respond_to(:users)
  end

  it "has opportunities" do
    expect(stubbed_state).to respond_to(:opportunities)
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

        @state_with_user_one = FactoryBot.create(:state, search: true, name: "AA")
        @state_with_user_two = FactoryBot.create(:state, search: true, name: "AB")
        @state_wo_user = FactoryBot.create(:state, search: true, name: "AC")
        user = FactoryBot.create(:user)
        user.states << @state_one
        user.states << @state_two
        user.states << @state_three

        user.states << @state_with_user_one
        user.states << @state_with_user_two

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

      it "cleans up states w/o a user" do
        State.to_scrape
        expect(State.find(@state_wo_user.id).search).to eq(false)
      end
    end
  end

  # Need to add 'active' tag to an opportunity. It's set false when the op doesn't appear in the search results.

  context ".active_opportunities" do
    before do
      @state = FactoryBot.create(:state)
    end

    context "when there are no opportunities" do
      it "returns an empty array" do
        expect(@state.active_opportunities.count).to eq(0)
      end
    end

    context "when there are no active opportunities" do
      before do
        @opportunity = FactoryBot.create(:opportunity, active: false, state: @state)
      end

      it "returns an empty array" do
        expect(@state.active_opportunities.count).to eq(0)
      end
    end

    context "when there are active opportunities" do
      before do
        @opportunity = FactoryBot.create(:opportunity, active: true, state: @state)
        @inactive_opp = FactoryBot.create(:opportunity, active: false, state: @state)
      end

      it "returns an array of those opportunities" do
        expect(@state.active_opportunities).to include(@opportunity)
      end

      it "doesn't include inactive opportunities" do
        expect(@state.active_opportunities).to_not include(@inactive_opp)
      end
    end
  end

  # context "#clean_dead_search_states" do
  #   before do
  #     @state_with_user_one = FactoryBot.create(:state, search: true, name: "AA")
  #     @state_with_user_two = FactoryBot.create(:state, search: true, name: "AB")
  #     @state_wo_user = FactoryBot.create(:state, search: true, name: "AC")
  #     user = FactoryBot.create(:user)
  #     user.states << @state_with_user_one
  #     user.states << @state_with_user_two
  #   end
  #
  #   it "sets any states w/o a user to search: false" do
  #     State.clean_dead_search_states
  #     expect(State.find(@state_wo_user.id).search).to eq(false)
  #   end
  #
  #   it "leaves any states with a user as search: true" do
  #     states_to_scrape = State.to_scrape
  #     expect(states_to_scrape).to include(@state_with_user_one)
  #     expect(states_to_scrape).to include(@state_with_user_two)
  #   end
  # end
end
