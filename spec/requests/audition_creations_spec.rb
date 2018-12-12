require 'rails_helper'

RSpec.describe "AuditionCreations", type: :request do
  context "with valid input" do
    before do
      project = FactoryBot.create(:project)
      category = FactoryBot.create(:category, name: "Foo")
      post '/api/v1/auditions',
        headers: { 'Accept':'application/json' },
        params: {
                  audition: {
                    bring: "Something you should bring",
                    prepare: "Something you should prepare",
                    project_id: project.id,
                    category_id: category.id
                  }
                }
    end

    it "returns 201 Created" do
      expect(response).to have_http_status(201)
    end

    it "creates the new audition" do
      expect(Audition.last.bring).to eq("Something you should bring")
      expect(Audition.last.prepare).to eq("Something you should prepare")
    end

    it "returns JSON with the new audition" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:bring]).to eq("Something you should bring")
      expect(body[:prepare]).to eq("Something you should prepare")
    end
  end

  context "with invalid input" do
    before do
      post '/api/v1/auditions',
        headers: { 'Accept':'application/json' },
        params: {
                  audition: {
                    bring: "",
                    prepare: "",
                    project_id: nil
                  }
                }
      @body = JSON.parse(response.body, symbolize_names: true)
    end
    it "returns 406 not accepted" do
      expect(response).to have_http_status(406)
    end

    it "returns JSON with error: true" do
      expect(@body[:error]).to eq(true)
    end

    it "returns a message param for useful info" do
      expect(@body[:message]).to eq("Audition is not valid")
    end
  end

end
