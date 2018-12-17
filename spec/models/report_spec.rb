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

  it "is valid without a result" do
    report.result_id = nil
    expect(report).to be_valid
  end

  it "is invalid without an audition" do
    report.audition_id = nil
    expect(report).to_not be_valid
  end

  describe ".result_text" do
    let(:result) { FactoryBot.create(:result, name: "Complete") }
    let(:category) {FactoryBot.create(:category)}
    let(:project) {FactoryBot.create(:project, user: user)}

    let(:audition) { FactoryBot.create(:audition, category: category, project: project, user: user) }

    context "when there is no result" do
      let(:report_for_result) { FactoryBot.create(:report, audition: audition) }

      it "returns nil" do
        expect(report_for_result.result_text).to eq(nil)
      end
    end

    context "when there is a result" do
      let(:report_for_result) { FactoryBot.create(:report, result: result, audition: audition) }

      it "returns the result's name" do
        expect(report_for_result.result_text).to eq(result.name)
      end
    end
  end
end
