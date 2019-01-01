require 'rails_helper'

RSpec.describe "Editing a project's result from the dashboard", type: :request do
  describe "PATCH /api/v1/dashboard/projects/:id" do

    context "with valid parameters" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')

        project = FactoryBot.create(:project, user: user)
        category = FactoryBot.create(:category, name: "Foo")
        audition = FactoryBot.create(:audition, project: project, category: category, user: user)
        @result = FactoryBot.create(:result, name: "A result")

        patch "/api/v1/dashboard/projects/#{project.id}",
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
           },
          params: {
              project: {
                result_id: @result.id
              }
            }
      end

      it "returns 202 Accepted" do
        expect(response).to have_http_status(202)
      end

      # it "updates the audition" do
      #   expect(Report.find(@report.id).notes).to eq("Some notes about the audition")
      # end

      # it "returns JSON with the new audition" do
      #   body = JSON.parse(response.body, symbolize_names: true)
      #   expect(body[:report][:notes]).to eq("Some notes about the audition")
      #   expect(body[:report][:people]).to eq("People you met at the audition")
      #   expect(body[:report][:auditors]).to eq("Some other people you met but in the room")
      # end
    end

  end
end
