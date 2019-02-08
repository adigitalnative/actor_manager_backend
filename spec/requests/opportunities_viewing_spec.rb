require 'rails_helper'

RSpec.describe "Accessing all opportunities via API", type: :request do
  describe "GET /api/v1/opportunities" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])

      @dc = FactoryBot.create(:state, name: "DC")
      user.states << @dc

      @non_displayed_opportunity = FactoryBot.create(:opportunity, state: FactoryBot.create(:state))
      @new_opportunity = FactoryBot.create(:opportunity, state: @dc)

      get '/api/v1/opportunities',
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }

       @body = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns a 200 OK status" do
      expect(response).to have_http_status(200)
    end
  end
end
