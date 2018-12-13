require 'rails_helper'

RSpec.describe "Project Lists", type: :request do
  describe "GET /api/v1/projects" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, 'the_secret')
      FactoryBot.create_list(:project, 10)
      get '/api/v1/projects',
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }
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
