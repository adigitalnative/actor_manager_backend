require 'rails_helper'

RSpec.describe "Project Lists", type: :request do
  describe "GET /api/v1/projects" do
    before do
      FactoryBot.create_list(:project, 10)
      get '/api/v1/projects'
    end

    it "returns a 200 OK status" do
      expect(response).to have_http_status(200)
    end

    it "includes all the current projects" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.count).to eq(10)
    end
  end
end
