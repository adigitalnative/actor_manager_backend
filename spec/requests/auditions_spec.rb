require 'rails_helper'

RSpec.describe "Auditions", type: :request do
  describe "getting a list of auditions at /api/v1/auditions" do
    it "returns 200 OK" do
      get api_v1_auditions_path
      expect(response).to have_http_status(200)
    end

    context "when there is at least one audition" do
      before do
        FactoryBot.create_list(:audition, 10)
        get '/api/v1/auditions'
      end

      it "returns the correct number of auditions" do
        body = JSON.parse(response.body)
        expect(body.size).to eq(10)
      end
    end
  end

  describe "creating an audition" do
    context "with valid input" do
      before do
        post '/api/v1/auditions',
          headers: { 'Accept':'application/json' },
          params: {
                    audition: {
                      bring: "Something you should bring",
                      prepare: "Something you should prepare"
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
    end

    context "with invalid input" do
      before do
        post '/api/v1/auditions',
          headers: { 'Accept':'application/json' },
          params: {
                    audition: {
                      bring: "",
                      prepare: ""
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

  describe "editing an existing audition" do
    before do
      @audition = FactoryBot.create(:audition, bring: "Something to bring", prepare: "Something to prepare")
    end

    context "with valid input" do
      before do
        patch '/api/v1/auditions/' + @audition.id.to_s,
          headers: { 'Accept':'application/json' },
          params: {
                    audition: {
                      bring: "A new thing",
                      prepare: "foo to prepare"
                    }
                  }
      end

      it "succeeds" do
        expect(Audition.find(@audition.id).bring).to eq("A new thing")
        expect(Audition.find(@audition.id).prepare).to eq("foo to prepare")
      end

      it "returns status accepted" do
        expect(response).to have_http_status(202)
      end

      it "returns the updated audition in the response body" do
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:bring]).to eq("A new thing")
        expect(body[:prepare]).to eq("foo to prepare")
      end
    end

    context "with invalid input" do
      before do
        patch '/api/v1/auditions/' + @audition.id.to_s,
          headers: { 'Accept':'application/json' },
          params: {
                    audition: {
                      bring: "",
                      prepare: ""
                    }
                  }
        @body = JSON.parse(response.body, symbolize_names: true)
      end
      it "returns 406 not accepted" do
        expect(response).to have_http_status(406)
      end

      it "has an error in the body" do
        expect(@body[:error]).to eq(true)
      end

      it "returns a message param for useful info" do
        expect(@body[:message]).to eq("Could not save audition")
      end
    end
  end

  describe "deleting an audition" do
    context "when the audition exists" do
      before do
        @audition_to_delete = FactoryBot.create(:audition)
        @audition_count = Audition.all.count
        delete '/api/v1/auditions/' + @audition_to_delete.id.to_s,
          headers: { 'Accept':'application/json' }
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
    end

    context "when the audition cannot be found" do
      before do
        @audition_to_delete = FactoryBot.create(:audition)
        @audition_to_delete_id = @audition_to_delete.id
        @audition_to_delete.destroy
        delete '/api/v1/auditions/' + @audition_to_delete.id.to_s,
          headers: { 'Accept':'application/json' }
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
end
