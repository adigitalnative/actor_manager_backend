require 'rails_helper'

RSpec.describe "Creating book items", type: :request do
  describe "POST /api/v1/book" do
    context "when the user exists and is signed in" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        post '/api/v1/book',
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
          },
          params: {
            book_item: {
              title: "Book Item Title",
              role: "Role in the book item"
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 201 CREATED" do
        expect(response).to have_http_status(201)
      end

      it "returns the expected data" do
        expect(@body[:title]).to eq("Book Item Title")
        expect(@body[:role]).to eq("Role in the book item")
      end
    end

    context "when the data is invalid" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        post '/api/v1/book',
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
          },
          params: {
            book_item: {
              title: "",
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns not acceptable" do
        expect(response).to have_http_status(406)
      end
    end

    context "when the user token does not exist or is invalid" do
      before do
        post '/api/v1/book'
      end

      it "returns a 401 not authorized" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
