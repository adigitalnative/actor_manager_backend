require 'rails_helper'

RSpec.describe "Project Lists", type: :request do
  describe "GET /api/v1/projects" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])
      FactoryBot.create_list(:project, 10, user: user)
      FactoryBot.create_list(:project, 10, user: FactoryBot.create(:user))
      get '/api/v1/projects',
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }
    end

    it "returns a 200 OK status" do
      expect(response).to have_http_status(200)
    end

    it "includes all the current user's projects" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body.count).to eq(10)
    end
  end
end
