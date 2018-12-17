require 'rails_helper'

RSpec.describe "User creation", type: :request do
  describe "POST /api/v1/users" do
    context "with valid parameters" do
      before do
        post '/api/v1/users',
        headers: { 'Accept':'application/json' },
        params: {
                  user: {
                    email: "foo@doe.com",
                    password: "password",
                    first_name: "Jane",
                    last_name: "Doe"
                  }
                }
      end

      it "returns appropriate status code" do 
        expect(response).to have_http_status(201)
      end

      it "creates the user" do
        expect(User.last.email).to eq("foo@doe.com")
      end
    end

    context "with invalid parameters" do
      before do
        post '/api/v1/users',
        headers: { 'Accept':'application/json' },
        params: {
                  user: {
                    email: "",
                    password: "",
                    first_name: "",
                    last_name: ""
                  }
                }
        @body = JSON.parse(response.body, symbolize_names: true)
      end
      it "returns the apropriate status code" do
        expect(response).to have_http_status(406)
      end

      it "returns an error message" do
        expect(@body[:message]).to eq("Failed to create user")
      end

      it "returns error: true" do
        expect(@body[:error]).to eq(true)
      end
    end
  end
end
