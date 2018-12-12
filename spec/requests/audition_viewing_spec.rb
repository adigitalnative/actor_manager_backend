require 'rails_helper'

RSpec.describe "Viewing auditions", type: :request do
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
end
