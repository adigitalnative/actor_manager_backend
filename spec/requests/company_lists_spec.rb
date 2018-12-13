require 'rails_helper'

RSpec.describe "CompanyLists", type: :request do
  describe "GET /companies" do
    before do
      FactoryBot.create_list(:company, 10)
      get '/api/v1/companies'
    end

    it "returns a 200 OK status" do
      expect(response).to have_http_status(200)
    end

    it "includes all the current companies" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.count).to eq(10)
    end
  end
end
