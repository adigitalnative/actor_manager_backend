require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { FactoryBot.build_stubbed(:company) }

  it "is valid with valid attributes" do
    expect(company).to be_valid
  end

  it "is invalid without a name" do
    company.name = nil
    expect(company).to_not be_valid
  end

  it "responds to .projects" do
    expect(company).to respond_to(:projects)
  end

  it "responds to user" do
    expect(company).to respond_to(:user)
  end

end
