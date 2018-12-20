require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:company) {FactoryBot.build_stubbed(:company) }
  let(:project) { FactoryBot.build_stubbed(:project, company: company) }

  it "is valid with valid attributes" do
    expect(project).to be_valid
  end

  it "is invalid without a name" do
    project.name = nil
    expect(project).to_not be_valid
  end

  it "responds to .company" do
    expect(project).to respond_to(:company)
  end

  it "is valid without a company" do
    project.company_id = nil
    expect(project).to be_valid
  end

  it "belongs to a user" do
    expect(project).to respond_to(:user)
  end

  it "can have a result" do
    expect(project).to respond_to(:result)
  end

  context(".percent_booked(user_id)") do
    let(:user) { FactoryBot.create(:user) }
    let(:booked_result) { FactoryBot.create(:result, booked: true)}
    let(:unbooked_result) { FactoryBot.create(:result, booked: false)}

    context "when there are no projects" do
      it "returns 0" do
        expect(Project.percent_booked(user)).to eq(0)
      end
    end

    context "when some projects are booked" do
      before do
        FactoryBot.create(:project, result: booked_result, user: user)
        FactoryBot.create(:project, result: unbooked_result, user:user)
      end

      it "returns the appropriate value" do
        expect(Project.percent_booked(user)).to eq(50)
      end

    end

    context "when all projects were booked" do
      before do
        FactoryBot.create(:project, result: booked_result, user: user)
        FactoryBot.create(:project, result: booked_result, user: user)
        FactoryBot.create(:project, result: booked_result, user: user)
      end

      it "returns the appropriate value" do
        expect(Project.percent_booked(user)).to eq(100)
      end
    end
  end
end
