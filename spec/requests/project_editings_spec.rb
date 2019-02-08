require 'rails_helper'

RSpec.describe "Editing a project", type: :request do
  describe "PATCH /api/v1/projects/:id" do
    context "with a user" do
      before do
        @user = FactoryBot.create(:user)
        @jwt = JWT.encode({user_id: @user.id}, ENV['JWT_SECRET'])
        @company = FactoryBot.create(:company, user: @user, name: "A Company")
        @project = FactoryBot.create(:project, company: @company, user: @user, name: "A project")
        @result = FactoryBot.create(:result)
      end

      context "with valid inputs" do
        before do
          patch '/api/v1/projects/' + @project.id.to_s,
            headers: {
              'Accept':'application/json',
              'Authorization':"Bearer #{@jwt}"
            },
            params: {
              project: {
                name: "New Project Name",
                result_id: @result.id
              }
            }
          @body = JSON.parse(response.body, symbolize_names: true)
        end

        it "returns a 202 Accepted" do
          expect(response).to have_http_status(202)
        end

        it "sets the project's result appropriately" do
          expect(Project.find(@project.id).result).to eq(@result)
        end
      end

      context "with invalid inputs" do
        before do
          patch '/api/v1/projects/' + @project.id.to_s,
            headers: {
              'Accept':'application/json',
              'Authorization':"Bearer #{@jwt}"
            },
            params: {
              project: {
                name: "",
              }
            }
          @body = JSON.parse(response.body, symbolize_names: true)
        end

        it "returns a useful status" do
          expect(response).to have_http_status(406)
        end

        it "returns an error" do
          expect(@body[:error]).to eq(true)
        end

      end
    end
  end
end
