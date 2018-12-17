require 'rails_helper'

RSpec.describe "Viewing your book", type: :request do
  describe "request to /api/v1/book" do
    context "when the user exists and is signed in" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        FactoryBot.create_list(:book_item, 10, user: user)
        get '/api/v1/book',
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 200 OK" do
        expect(response).to have_http_status(200)
      end

      it "returns the expected data" do
        expect(@body.count).to eq(10)
      end
    end

    context "when the user token does not exist or is invalid" do
      before do
        get '/api/v1/book'
      end

      it "returns a 401 not authorized" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
