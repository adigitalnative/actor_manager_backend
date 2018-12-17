require 'rails_helper'

RSpec.describe Audition, type: :model do
  let(:audition) { FactoryBot.build_stubbed(:audition) }

  it "is valid with valid inputs" do
    expect(audition).to be_valid
  end

  it "is invalid without what to bring" do
    audition.bring = nil
    expect(audition).to_not be_valid
  end

  it "is invalid without what to prepare" do
    audition.prepare = nil
    expect(audition).to_not be_valid
  end

  it "can have projects" do
    expect(audition).to respond_to(:project)
  end

  it "can have a company" do
    expect(audition).to respond_to(:company)
  end

  it "has a category" do
    expect(audition).to respond_to(:category)
  end

  it "belongs to a user" do
    expect(audition).to respond_to(:user)
  end

  it "has a report" do
    expect(audition).to respond_to(:report)
  end
end
