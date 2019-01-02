require 'rails_helper'

RSpec.describe "Archiving a lead", type: :request do
  describe "PATCH /leads/:id/archive" do
    context "when the lead exists and is not archived" do
      before do
        @user = FactoryBot.create(:user)
        jwt = JWT.encode({user_id: @user.id}, 'the_secret')

        @dc = FactoryBot.create(:state, name: "DC")
        @user.states << @dc

        @opportunity = FactoryBot.create(:opportunity, state: @dc)
        Lead.generate_for(@user)

        patch '/api/v1/opportunities/' + @opportunity.id.to_s + '/archive',
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{jwt}"
         }
         @body = JSON.parse(response.body, symbolize_names: true)
      end

      it "returns a good status message" do
        expect(response).to have_http_status(202)
      end

      it "sets the .archive? to true" do
        expect(@user.leads.find_by(opportunity_id: @opportunity.id).archived).to eq(true)
      end

      it "returns the updated lead" do
        expect(@body[:opportunity][:id]).to eq(@opportunity.id)
      end
    end
  end
end
