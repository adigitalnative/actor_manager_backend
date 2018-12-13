require 'rails_helper'

RSpec.describe "CategoryLists", type: :request do
  describe "GET /categories" do
    before do
      FactoryBot.create_list(:category, 10)
      get '/api/v1/categories'
    end

    it "returns a 200 OK status" do
      expect(response).to have_http_status(200)
    end

    it "includes all the current categories" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.count).to eq(10)
    end
  end
end
