require 'rails_helper'

RSpec.describe "Editing the current user", type: :request do
  describe "PATCH /users" do
    before do
      user = FactoryBot.create(:user, first_name: "Jane", last_name: "Doe")
      @jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])
      @dc = State.create(name: "DC")
      @md = State.create(name: "MD")
      @va = State.create(name: "VA")
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
              last_name: "Hah",
              audition_states: ["DC", "MD", "VA"]
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 202 accepted" do
        expect(response).to have_http_status(202)
      end

      it "returns a user with the new first and last names" do
        expect(@body[:first_name]).to eq("Foo")
        expect(@body[:last_name]).to eq("Hah")
      end

      it "returns a user with the proper audition states" do
        expect(@body[:states].count).to eq(3)
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
              last_name: "",
              audition_states: []
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
