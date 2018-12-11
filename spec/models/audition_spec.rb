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
end
