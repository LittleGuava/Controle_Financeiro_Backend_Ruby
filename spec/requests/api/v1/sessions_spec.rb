require 'rails_helper'

RSpec.describe 'Sessions API v1', type: :request do
    let!(:user) { create(:user) }
    let!(:old_token) { user.auth_token }
    let(:headers) { { "Accept" => "application/vnd.projetofase8.v1" } }

    before { host! "localhost:3000/api" }

    describe "POST /sessions" do
        before do
            post "/sessions", params: { session: { email: user.email, password: password } }, headers: headers
        end

        context "when the credentials are correct" do
            let(:password) { "123456" }

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end

            it "returns the user with a new auth token" do
                expect(json_body["auth_token"]).to eq(user.reload.auth_token)
                expect(json_body["auth_token"]).not_to eq(old_token)
            end
        end

        context "when the credentials are incorrect" do
            let(:password) { "errada" }

            it "returns status code 401" do
                expect(response).to have_http_status(401)
            end

            it "returns json data for the errors" do
                expect(json_body).to have_key('errors')
            end
        end
    end
end
