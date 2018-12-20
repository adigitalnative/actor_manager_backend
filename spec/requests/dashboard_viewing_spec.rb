require 'rails_helper'

RSpec.describe "Dashboard request", type: :request do
  describe "GET /api/v1/dashboard" do
    context "with a valid user" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        project_one = FactoryBot.create(:project, user: user)
        project_two = FactoryBot.create(:project, user: user)
        project_three = FactoryBot.create(:project, user: user)
        project_four = FactoryBot.create(:project, user: user)

        get '/api/v1/dashboard',
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{jwt}"
         }
         @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 200 OK status" do
        expect(response).to have_http_status(200)
      end

      it "returns a list of projects" do
        expect(@body[:projects].class).to eq(Array)
      end
      it "includes the right number of projects" do
        expect(@body[:projects].count).to eq(4)
      end

      it "includes a projects company" do
        expect(@body[:projects][0].keys).to include(:company)
      end

      it "includes a projects' auditions" do
        expect(@body[:projects][0].keys).to include(:auditions)
      end

      # As needed for dashboard display
      it "returns % of projects booked" do
        expect(@body.keys).to include(:percent_booked)
      end

      it "returns an array of auditions/month"
      it "returns an array of auditions/week"
      it "returns an array of auditions/year"
      it "returns an array of all auditions"
    end

    context "without a valid user" do

    end
  end
end
