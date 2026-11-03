require 'rails_helper'

RSpec.describe 'Gains API v2', type: :request do
    let!(:user) { create(:user) }
    let(:headers) { { "Accept" => "application/vnd.projetofase8.v2" }.merge(user.create_new_auth_token) }

    before { host! "localhost:3000/api" }

    describe "POST /gains with a date" do
        before do
            post "/gains", params: { gain: { description: "Freela", value: 300, date: "2026-10-05" } }, headers: headers
        end

        it "returns status code 201" do
            expect(response).to have_http_status(201)
        end

        it "returns the date formatted in pt-BR" do
            expect(json_body["data"]["attributes"]["date-to-br"]).to eq("05/10/26")
        end
    end

    describe "PUT /gains/:id" do
        let!(:gain) { user.gains.create!(description: "Freela", value: 300) }

        it "updates the gain" do
            put "/gains/#{gain.id}", params: { gain: { description: "Freela 2" } }, headers: headers

            expect(response).to have_http_status(200)
            expect(json_body["data"]["attributes"]["description"]).to eq("Freela 2")
        end
    end

    describe "GET /gains with the dashboard query" do
        let!(:first) { user.gains.create!(description: "Salario", value: 1500, date: Date.new(2026, 10, 1)) }
        let!(:second) { user.gains.create!(description: "Freela", value: 300) }

        it "returns every gain sorted by id" do
            get "/gains", params: { q: { description_cont: "", s: "id ASC" } }, headers: headers

            expect(response).to have_http_status(200)
            expect(json_body["data"].map { |g| g["id"] }).to eq([first.id.to_s, second.id.to_s])
        end

        it "filters by description" do
            get "/gains", params: { q: { description_cont: "Free" } }, headers: headers

            expect(json_body["data"].map { |g| g["attributes"]["description"] }).to eq(["Freela"])
        end
    end
end
