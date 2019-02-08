require 'rails_helper'

RSpec.describe "CompanyLists", type: :request do
  describe "GET /companies" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])
      FactoryBot.create_list(:company, 10, user: user)
      get '/api/v1/companies',
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }
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
