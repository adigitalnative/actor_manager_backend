require 'rails_helper'

RSpec.describe Lead, type: :model do
  let(:lead) { FactoryBot.build_stubbed(:lead) }

  it "is valid with valid attributes" do
    expect(lead).to be_valid
  end

  it "is invalid without an opportunity" do
    lead.opportunity = nil
    expect(lead).to_not be_valid
  end

  it "is invalid without a user" do
    lead.user = nil
    expect(lead).to_not be_valid
  end

  it "is invalid without 'new' boolean" do
    lead.new = nil
    expect(lead).to_not be_valid
  end

  it "is invalid without an 'archived' boolean" do
    lead.archived = nil
    expect(lead).to_not be_valid
  end

  describe "#generate_for(user)" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "when the user has at least one state" do
      before do
        @state = FactoryBot.create(:state, name: "ZP")
        @user.states << @state
      end

      context "when the state has at least one opportunity" do
        before do
          @opportunity = FactoryBot.create(:opportunity, state: @state)
        end

        context "when the user has already seen that opportunity" do
          before do
            @user.leads.create(opportunity: @opportunity)
            @lead_count = @user.leads.count
          end

          it "returns true" do
            expect(Lead.generate_for(@user)).to eq(true)
          end

          it "doesn't create a lead" do
            Lead.generate_for(@user)
            expect(@user.leads.count).to eq(@lead_count)
          end

          xit "sets the associated lead as not new" do
            expect(@user.leads.last.new?).to eq(false)
          end
        end

        context "when the user has not yet seen that opportunity" do
          before do
            @lead_count = @user.leads.count
          end

          it "returns true" do
            expect(Lead.generate_for(@user)).to eq(true)
          end

          it "creates a lead for the user & opportunity" do
            Lead.generate_for(@user)
            expect(@user.leads.count - 1).to eq(@lead_count)
          end

          context "when the opportunity is stale" do
            before do
              @opportunity.update(active: false)
            end

            it "returns true" do
              expect(Lead.generate_for(@user)).to eq(true)
            end
            it "doesn't create a lead" do
              Lead.generate_for(@user)
              expect(@user.leads.count).to eq(@lead_count)
            end
          end
        end

      end

      context "when the state has no opportunities" do
        it "returns true" do
          expect(Lead.generate_for(@user)).to eq(true)
        end
      end
    end

    context "when the user has no states" do
      it "returns true" do
        expect(Lead.generate_for(@user)).to eq(true)
      end
    end
  end

end
