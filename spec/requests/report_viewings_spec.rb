require 'rails_helper'

RSpec.describe "ReportViewings", type: :request do
  describe "GET /api/v1/report/:id" do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, user: user) }
    let(:audition) { FactoryBot.create(:audition, user: user, category: FactoryBot.create(:category), project: project) }
    let(:report) {FactoryBot.create(:report, audition: audition )}

    it "works! (now write some real specs)" do
      get "/api/v1/reports/#{report.id}"
      expect(response).to have_http_status(200)
    end
  end
end
