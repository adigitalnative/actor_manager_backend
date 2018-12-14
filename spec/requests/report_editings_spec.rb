require 'rails_helper'

RSpec.describe "Editing a report", type: :request do
  describe "PATCH /api/v1/auditions/:audition_id/report" do

    context "with valid parameters" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')

        project = FactoryBot.create(:project, user: user)
        category = FactoryBot.create(:category, name: "Foo")
        audition = FactoryBot.create(:audition, project: project, category: category, user: user)
        @report = FactoryBot.create(:report, audition: audition)

        patch "/api/v1/auditions/#{audition.id}/report",
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
           },
          params: {
              report: {
                notes: "Some notes about the audition",
                people: "People you met at the audition",
                auditors: "Some other people you met but in the room"
              }
            }
      end

      it "returns 201 Created" do
        expect(response).to have_http_status(202)
      end

      it "updates the audition" do
        expect(Report.find(@report.id).notes).to eq("Some notes about the audition")
      end

      it "returns JSON with the new audition" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:notes]).to eq("Some notes about the audition")
        expect(body[:people]).to eq("People you met at the audition")
        expect(body[:auditors]).to eq("Some other people you met but in the room")
      end
    end
    
  end
end
