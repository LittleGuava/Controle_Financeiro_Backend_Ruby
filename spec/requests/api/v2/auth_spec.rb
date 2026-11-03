require 'rails_helper'

RSpec.describe 'Auth API v2', type: :request do
    let!(:user) { create(:user) }
    let(:auth_headers) { %w[access-token client uid expiry token-type] }

    before { host! "localhost:3000/api" }

    describe "POST /auth/sign_in" do
        before do
            post "/auth/sign_in", params: { email: user.email, password: password }, headers: { "Accept" => "application/vnd.projetofase8.v2" }
        end

        context "with valid credentials" do
            let(:password) { "123456" }

            it "returns status code 200" do
                expect(response).to have_http_status(200)
            end

            it "returns the token headers the front reads" do
                auth_headers.each { |h| expect(response.headers[h]).to be_present, "faltou o header #{h}" }
                expect(response.headers["uid"]).to eq(user.email)
            end
        end

        context "with an invalid password" do
            let(:password) { "errada" }

            it "returns status code 401" do
                expect(response).to have_http_status(401)
            end
        end
    end

    describe "GET /auth/validate_token" do
        it "accepts the headers returned by sign_in" do
            post "/auth/sign_in", params: { email: user.email, password: "123456" }
            headers = response.headers.to_h.slice(*auth_headers)

            get "/auth/validate_token", headers: headers

            expect(response).to have_http_status(200)
            expect(json_body["data"]["email"]).to eq(user.email)
        end
    end
end
