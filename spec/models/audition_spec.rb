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

  it "can have many pieces" do
    expect(audition).to respond_to(:pieces)
  end

  it "can have a date & time" do
    expect(audition).to respond_to(:date_and_time)
  end

  context ".percent_reported" do
    let(:category) { FactoryBot.create(:category) }
    let(:project) { FactoryBot.create(:project) }

    before do
      @user = FactoryBot.create(:user)
      @category = FactoryBot.create(:category)
      @project = FactoryBot.create(:project, user: @user)
    end

    context "when there are no auditions" do
      it "returns 'N/A'" do
        expect(Audition.percent_reported(@user)).to eq('N/A')
      end
    end

    context "when there are auditions but no reports" do
      before do
        FactoryBot.create(:audition, user: @user, category: @category, project: @project)
      end

      it "returns 0" do
        expect(Audition.percent_reported(@user)).to eq(0)
      end
    end

    context "when some auditions have reports" do

      before do
        audit_one = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_one.report.update(people: "something to make it a thing")
        audit_two = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_two.report.update(people: "something to make it a thing")
        audit_three = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_for = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
      end

      it "returns the appropriate percentage" do
        expect(Audition.percent_reported(@user)).to eq(50)
      end
    end

    context "when all auditions have reports" do
      before do
        audit_one = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_one.report.update(people: "something to make it a thing")
        audit_two = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_two.report.update(people: "something to make it a thing")
        audit_three = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_three.report.update(people: "something to make it a thing")
        audit_for = FactoryBot.create(:audition, user: @user, category: @category, project: @project)
        audit_for.report.update(people: "something to make it a thing")
      end

      it "returns 100" do
        expect(Audition.percent_reported(@user)).to eq(100)
      end
    end

  end
end
