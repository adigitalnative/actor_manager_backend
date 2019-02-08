require 'rails_helper'

RSpec.describe "Editing a company", type: :request do
  context "with a user" do
    before do
      @user = FactoryBot.create(:user)
      @jwt = JWT.encode({user_id: @user.id}, ENV['JWT_SECRET'])
      @company = FactoryBot.create(:company, user: @user, name: "A Company")
    end

    context "with valid inputs" do
      before do
        patch '/api/v1/companies/' + @company.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{@jwt}"
          },
          params: {
            company: {
              name: "New Company Name",
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 202 Accepted" do
        expect(response).to have_http_status(202)
      end
    end

    context "with invalid inputs" do
      before do
        patch '/api/v1/companies/' + @company.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{@jwt}"
          },
          params: {
            company: {
              name: "",
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a useful status" do
        expect(response).to have_http_status(406)
      end

      it "returns an error" do
        expect(@body[:error]).to eq(true)
      end

    end
  end
end
