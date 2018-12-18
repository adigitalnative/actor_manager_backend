require 'rails_helper'

RSpec.describe "Deleting book items", type: :request do
  describe "DELETE /api/v1/book/:id" do

    let(:user) { FactoryBot.create(:user) }
    let(:jwt) { JWT.encode({user_id: user.id}, 'the_secret') }

    before do
      @book_to_delete = FactoryBot.create(:book_item, user: user)
      @book_item_count = BookItem.all.count
      @book_to_delete.auditions << FactoryBot.create(:audition, user: user, project: FactoryBot.create(:project, user: user), category: FactoryBot.create(:category))
    end


    context "when the book item exists" do
      before do
        delete '/api/v1/book/' + @book_to_delete.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
           }
      end

      it "returns a 202 accepted" do
        expect(response).to have_http_status(202)
      end

      it "deletes the book_item" do
        expect(BookItem.count).to eq(@book_item_count - 1)
      end
    end

    context "when the book item does not exist" do
      before do
        delete '/api/v1/book/' + (BookItem.all.last.id + 1).to_s
      end

      it "returns a not accepted" do
        expect(response).to have_http_status(401)
      end
    end

    context "when the book belongs to a different user" do
      before do
        other_book_to_delete = FactoryBot.create(:book_item, user: FactoryBot.create(:user))
        delete '/api/v1/book/' + other_book_to_delete.id.to_s,
          headers: {
            'Accept':'application/json',
            'Authorization':"Bearer #{jwt}"
           }
      end

      it "returns a not accepted" do
        expect(response).to have_http_status(406)
      end
    end

    context "when the user token does not exist or is invalid" do
      before do
        delete '/api/v1/book/' + @book_to_delete.id.to_s
      end

      it "returns a 401 not authorized" do
        expect(response).to have_http_status(401)
      end
    end
  end
end
