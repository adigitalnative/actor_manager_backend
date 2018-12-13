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
end
