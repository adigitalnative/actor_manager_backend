require 'rails_helper'

RSpec.describe Opportunity, type: :model do
  let(:opportunity) { FactoryBot.build_stubbed(:opportunity)}

  it "is valid with valid attributes" do
    expect(opportunity).to be_valid
  end

  it "is invalid without a source" do
    opportunity.source = nil
    expect(opportunity).to_not be_valid
  end

  it "is invalid without a title" do
    opportunity.title = nil
    expect(opportunity).to_not be_valid
  end

  it "is invalid without a company" do
    opportunity.company = nil
    expect(opportunity).to_not be_valid
  end

  it "is invalid without a url" do
    opportunity.url = nil
    expect(opportunity).to_not be_valid
  end

  it "is invalid without a state" do
    opportunity.state = nil
    expect(opportunity).to_not be_valid
  end

  it "is invalid without an active? boolean" do
    opportunity.active = nil
    expect(opportunity).to_not be_valid
  end

  context "url" do
    before do
      state = FactoryBot.create(:state)
      @opportunity = FactoryBot.build(:opportunity, state: state)
    end

    context "when the url starts with 'http://'" do
      it "saves the URL without the prefix" do
        @opportunity.url = "http://thisisthelocation.com/auditions/ladjf8493akjdf"
        @opportunity.save
        expect(Opportunity.find(@opportunity.id).url).to eq("thisisthelocation.com/auditions/ladjf8493akjdf")
      end
    end

    context "when the url starts with 'https://'" do
      it "saves the url without the prefix" do
        @opportunity.url = "https://thisisthelocation.com/auditions/ladjf8493akjdf"
        @opportunity.save
        expect(Opportunity.find(@opportunity.id).url).to eq("thisisthelocation.com/auditions/ladjf8493akjdf")
      end
    end
  end
end
