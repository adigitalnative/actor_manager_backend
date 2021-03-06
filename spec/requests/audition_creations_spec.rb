require 'rails_helper'

RSpec.describe "AuditionCreations", type: :request do
  context "with valid input" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])
      project = FactoryBot.create(:project, user: user)
      category = FactoryBot.create(:category, name: "Foo")
      @piece = FactoryBot.create(:book_item, user: user)
      post '/api/v1/auditions',
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{jwt}"
         },
        params: {
                  audition: {
                    bring: "Something you should bring",
                    prepare: "Something you should prepare",
                    project_id: project.id,
                    category_id: category.id,
                    book_item_ids: [@piece.id]
                  }
                }
    end

    it "returns 201 Created" do
      expect(response).to have_http_status(201)
    end

    it "creates the new audition" do
      expect(Audition.last.bring).to eq("Something you should bring")
      expect(Audition.last.prepare).to eq("Something you should prepare")
    end

    it "returns JSON with the new audition" do
      body = JSON.parse(response.body, symbolize_names: true)
      expect(body[:bring]).to eq("Something you should bring")
      expect(body[:prepare]).to eq("Something you should prepare")
    end

    it "connects book_items if provided" do
      expect(Audition.last.pieces).to include(@piece)
    end
  end

  context "with invalid input" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, ENV['JWT_SECRET'])
      post '/api/v1/auditions',
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{jwt}"
         },
        params: {
                  audition: {
                    bring: "",
                    prepare: "",
                    project_id: nil
                  }
                }
      @body = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns 406 not accepted" do
      expect(response).to have_http_status(406)
    end

    it "returns JSON with error: true" do
      expect(@body[:error]).to eq(true)
    end

    it "returns a message param for useful info" do
      expect(@body[:message]).to eq("Audition is not valid")
    end
  end

end
