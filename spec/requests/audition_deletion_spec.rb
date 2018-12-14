require 'rails_helper'

RSpec.describe "Deleting an audition", type: :request do
  context "when the audition exists" do
    before do
      user = FactoryBot.create(:user)
      @jwt = JWT.encode({user_id: user.id}, 'the_secret')
      project = FactoryBot.create(:project, user: user)
      category = FactoryBot.create(:category)
      @audition_to_delete = FactoryBot.create(:audition, project: project, category: category, user: user)
      @another_user_audition = FactoryBot.create(:audition, project: FactoryBot.create(:project, user: user),
        category: FactoryBot.create(:category), user: FactoryBot.create(:user))
      @audition_count = Audition.all.count

      delete '/api/v1/auditions/' + @audition_to_delete.id.to_s,
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{@jwt}"
         }
      @body = JSON.parse(response.body, symbolize_names: true)
    end

    it "deletes the audition" do
      expect(Audition.all.count).to eq(@audition_count - 1)
    end

    it "returns an apropriate status code" do
      expect(response).to have_http_status(202)
    end

    it "returns a copy of the deleted audition" do
      expect(@body[:id]).to eq(@audition_to_delete.id)
    end

    it "does not allow deletion of another user's audition" do
      delete '/api/v1/auditions/' + @another_user_audition.id.to_s,
        headers: {
          'Accept':'application/json',
          'Authorization':"Bearer #{@jwt}"
         }
      expect(response).to have_http_status(406)
    end
  end

  context "when the audition cannot be found" do
    before do
      user = FactoryBot.create(:user)
      jwt = JWT.encode({user_id: user.id}, 'the_secret')
      project = FactoryBot.create(:project, user: user)
      category = FactoryBot.create(:category)
      @audition_to_delete = FactoryBot.create(:audition, project: project, category: category, user: user)
      @audition_to_delete_id = @audition_to_delete.id
      @audition_to_delete.destroy
      delete '/api/v1/auditions/' + @audition_to_delete.id.to_s,
      headers: {
        'Accept':'application/json',
        'Authorization':"Bearer #{jwt}"
       }
      @body = JSON.parse(response.body, symbolize_names: true)
    end

    it "returns status 406 not accepted" do
      expect(response).to have_http_status(406)
    end

    it "returns an error" do
      expect(@body[:error]).to eq(true)
    end

    it "has a useful error message" do
      expect(@body[:message]).to eq("Could not delete audition")
    end
  end
end
