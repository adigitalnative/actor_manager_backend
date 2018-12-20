require 'rails_helper'

RSpec.describe "Editing Book Items", type: :request do
  describe "PATCH /api/v1/book/:id" do
    context "when the user exists and is signed in" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        book_to_edit = FactoryBot.create(:book_item, user: user)
        patch '/api/v1/book/' + book_to_edit.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
          },
          params: {
            book_item: {
              title: "New Book Item Title",
              role: "New Role in the book item"
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a 202 Accepted" do
        expect(response).to have_http_status(202)
      end

      it "returns the expected data" do
        expect(@body[:title]).to eq("New Book Item Title")
        expect(@body[:role]).to eq("New Role in the book item")
      end
    end

    context "when the data is invalid" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        book_to_edit = FactoryBot.create(:book_item, user: user)

        patch '/api/v1/book/' + book_to_edit.id.to_s,
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

    context "editing the 'prepared sides' book item" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        book_to_edit = user.book_items.find_by_title("Prepared Sides")
        patch '/api/v1/book/' + book_to_edit.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
          },
          params: {
            book_item: {
              title: "New Book Item Title",
              role: "New Role in the book item"
            }
          }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns not acceptable" do
        expect(response).to have_http_status(406)
      end

      it "returns a useful error message" do
        expect(@body[:message]).to eq("Can't change this book item.")
      end
    end

    context "when the user token does not exist or is invalid" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        book_to_edit = FactoryBot.create(:book_item, user: user)
        patch '/api/v1/book/' + book_to_edit.id.to_s
      end

      it "returns a 401 not authorized" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
