require 'rails_helper'

RSpec.describe "Viewing auditions", type: :request do
  describe "getting a list of auditions at /api/v1/auditions" do
    it "returns 200 OK" do
      get api_v1_auditions_path
      expect(response).to have_http_status(200)
    end

    context "when there is at least one audition" do
      before do
        category = FactoryBot.create(:category, name: "Callback")
        @company = FactoryBot.create(:company, name: "A company")
        @project = FactoryBot.create(:project, name: "A Project", company: @company)
        FactoryBot.create_list(:audition, 10, project: @project, category: category)
        @audition_to_find = FactoryBot.create(:audition, project: @project,
          bring: "The thing to bring", prepare: "The thing to prepare", category: category)
        get '/api/v1/auditions'
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns the correct number of auditions" do
        expect(@body.size).to eq(11)
      end

      it "includes the associated project" do
        expect(@body.last[:project]).to eq("A Project")
      end

      it "includes the associated company" do
        expect(@body.last[:company]).to eq("A company")
      end

      it "includes the associated categories" do
        expect(@body.last[:category]).to eq("Callback")
      end
    end
  end
end
