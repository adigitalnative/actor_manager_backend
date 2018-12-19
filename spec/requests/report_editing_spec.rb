require 'rails_helper'

RSpec.describe "Editing a report", type: :request do
  before do
    @user = FactoryBot.create(:user)
    @project = FactoryBot.create(:project, user: @user)
    category = FactoryBot.create(:category)
    @audition = FactoryBot.create(:audition, bring: "Something to bring",
      prepare: "Something to prepare", project: @project, category: category,
      user: @user
    )
    @jwt = JWT.encode({user_id: @user.id}, 'the_secret')
  end

  context "with valid input" do
    before do
      patch '/api/v1/auditions/' + @audition.id.to_s + "/report",
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{@jwt}"
       },
        params: {
          report: {
            notes: "Some notes",
            people: "Some poeple were seen",
            auditors: "There were more people in the room"
          }
        }
    end

    it "succeeds" do
      expect(Audition.find(@audition.id).report.notes).to eq("Some notes")
      expect(Audition.find(@audition.id).report.people).to eq("Some poeple were seen")
      expect(Audition.find(@audition.id).report.auditors).to eq("There were more people in the room")
    end

    it "returns status accepted" do
      expect(response).to have_http_status(202)
    end

    it "returns the updated audition in the response body" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:report][:notes]).to eq("Some notes")
      expect(body[:report][:people]).to eq("Some poeple were seen")
      expect(body[:report][:auditors]).to eq("There were more people in the room")
    end

  end

  context "with a result" do
    let(:result) { FactoryBot.create(:result, name: "Successful") }

    before do
      patch '/api/v1/auditions/' + @audition.id.to_s + "/report",
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{@jwt}"
       },
        params: {
          report: {
            notes: "Some notes",
            people: "Some poeple were seen",
            auditors: "There were more people in the room",
            result_id: result.id
          }
        }
    end

    it "saves the result on the associated project" do
      expect(Project.find(@project.id).result_id).to eq(result.id)
    end

    it "includes the result in the audition response" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:result][:id]).to eq(result.id)
    end
  end

  context "with invalid input" do
    before do
      jwt = JWT.encode({user_id: @user.id}, 'the_secret')
      patch '/api/v1/auditions/' + @audition.id.to_s,
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       },
        params: {
                  audition: {
                    bring: "",
                    prepare: ""
                  }
                }
      @body = JSON.parse(response.body, symbolize_names: true)
    end
    it "returns 406 not accepted" do
      expect(response).to have_http_status(406)
    end

    it "has an error in the body" do
      expect(@body[:error]).to eq(true)
    end

    it "returns a message param for useful info" do
      expect(@body[:message]).to eq("Could not save audition")
    end

    it "does not allow editing of another user's audition"
    it "doesn't allow editing without a token"
  end
end
