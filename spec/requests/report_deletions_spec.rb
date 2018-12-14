require 'rails_helper'

RSpec.describe "ReportDeletions", type: :request do
  describe "DELETE /api/v1/auditions/:audition_id/report" do

    context "with valid parameters" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')

        project = FactoryBot.create(:project, user: user)
        category = FactoryBot.create(:category, name: "Foo")
        audition = FactoryBot.create(:audition, project: project, category: category, user: user)
        @report = FactoryBot.create(:report, audition: audition)
        @report_count = Report.all.count

        delete "/api/v1/auditions/#{audition.id}/report",
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
           }
      end

      it "returns 201 Created" do
        expect(response).to have_http_status(202)
      end

      it "deletes a report" do
        expect(Report.all.count).to eq(@report_count - 1)
      end

      it "returns JSON with the old report" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:id]).to eq(@report.id)
      end
    end


  end
end
