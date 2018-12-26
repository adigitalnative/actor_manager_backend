require 'rails_helper'

RSpec.describe "Editing the current user", type: :request do
  describe "PATCH /users" do
    before do
      user = FactoryBot.create(:user, first_name: "Jane", last_name: "Doe")
      @jwt = JWT.encode({user_id: user.id}, 'the_secret')
    end
    context "with valid input" do
      before do
        patch '/api/v1/users',
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{@jwt}"
          },
          params: {
            user: {
              first_name: "Foo",
              last_name: "Hah"
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 202 accepted" do
        expect(response).to have_http_status(202)
      end

      it "returns a user with the new first and last names" do
        expect(@body[:user][:first_name]).to eq("Foo")
        expect(@body[:user][:last_name]).to eq("Hah")
      end
    end

    context "with invalid input" do
      before do
        patch '/api/v1/users',
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{@jwt}"
          },
          params: {
            user: {
              first_name: "",
              last_name: ""
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "has a good HTTP status" do
        expect(response).to have_http_status(406)
      end
    end



  end
end
