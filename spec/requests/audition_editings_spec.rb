require 'rails_helper'

RSpec.describe "Editing an audition", type: :request do
  before do
    project = FactoryBot.create(:project)
    category = FactoryBot.create(:category)
    @audition = FactoryBot.create(:audition, bring: "Something to bring", prepare: "Something to prepare", project: project, category: category)
  end

  context "with valid input" do
    before do
      patch '/api/v1/auditions/' + @audition.id.to_s,
        headers: { 'Accept':'application/json' },
        params: {
                  audition: {
                    bring: "A new thing",
                    prepare: "foo to prepare"
                  }
                }
    end

    it "succeeds" do
      expect(Audition.find(@audition.id).bring).to eq("A new thing")
      expect(Audition.find(@audition.id).prepare).to eq("foo to prepare")
    end

    it "returns status accepted" do
      expect(response).to have_http_status(202)
    end

    it "returns the updated audition in the response body" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:bring]).to eq("A new thing")
      expect(body[:prepare]).to eq("foo to prepare")
    end
  end

  context "with invalid input" do
    before do
      patch '/api/v1/auditions/' + @audition.id.to_s,
        headers: { 'Accept':'application/json' },
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
  end
end
