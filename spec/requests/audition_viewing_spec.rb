require 'rails_helper'

RSpec.describe "Viewing auditions", type: :request do
  describe "getting a list of auditions at /api/v1/auditions" do
    it "returns 200 OK" do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, 'the_secret')
      get api_v1_auditions_path,
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }
      expect(response).to have_http_status(200)
    end

    context "when there is at least one audition" do
      before do
        user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: user.id}, 'the_secret')
        category = FactoryBot.create(:category, name: "Callback")
        @company = FactoryBot.create(:company, name: "A company")
        @project = FactoryBot.create(:project, name: "A Project", company: @company, user: user)
        FactoryBot.create_list(:audition, 10, project: @project, category: category, user: user)
        @audition_to_find = FactoryBot.create(:audition, project: @project,
          bring: "The thing to bring", prepare: "The thing to prepare", category: category, user: user)
        @audition_to_not_find = FactoryBot.create(:audition, project: FactoryBot.create(:project, user: FactoryBot.create(:user) ),
          bring: "Foo", prepare: "Foo", category: FactoryBot.create(:category), user: FactoryBot.create(:user))

        get '/api/v1/auditions',
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{jwt}"
         }
        @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns the correct number of auditions" do
        expect(@body.size).to eq(11)
      end

      it "includes the associated project" do
        expect(@body.last[:project]).to eq("A Project")
      end

      it "includes the associated company" do
        expect(@body.last[:company]).to eq("A company")
      end

      it "includes the associated categories" do
        expect(@body.last[:category]).to eq("Callback")
      end

      it "returns only the user's auditions" do
        expect(@body.last[:bring]).to_not eq("Foo")
      end
    end
  end
end
