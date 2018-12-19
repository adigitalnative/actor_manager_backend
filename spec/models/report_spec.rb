require 'rails_helper'

RSpec.describe Report, type: :model do


  let(:user) { FactoryBot.create(:user) }

  let(:result) { FactoryBot.create(:result, name: "Complete") }
  let(:category) {FactoryBot.create(:category)}
  let(:project) {FactoryBot.create(:project, user: user)}

  let(:audition) { FactoryBot.create(:audition, category: category, project: project, user: user) }


  let(:report) { FactoryBot.create(:report, audition: audition )}

  it "is valid with valid attributes" do
    expect(report).to be_valid
  end

  it "is does not respond to result" do
    expect(report).to_not respond_to(:result)
  end

  it "is invalid without an audition" do
    report.audition_id = nil
    expect(report).to_not be_valid
  end

end
