require 'rails_helper'

RSpec.describe 'Expenses API v2', type: :request do
    let!(:user) { create(:user) }
    let(:headers) { { "Accept" => "application/vnd.projetofase8.v2" }.merge(user.create_new_auth_token) }

    before { host! "localhost:3000/api" }

    describe "POST /expenses with a date" do
        before do
            post "/expenses", params: { expense: { description: "Freela", value: 300, date: "2026-10-05" } }, headers: headers
        end

        it "returns status code 201" do
            expect(response).to have_http_status(201)
        end

        it "returns the date formatted in pt-BR" do
            expect(json_body["data"]["attributes"]["date-to-br"]).to eq("05/10/26")
        end
    end

    describe "GET /expenses with the dashboard query" do
        let!(:first) { user.expenses.create!(description: "Salario", value: 1500, date: Date.new(2026, 10, 1)) }
        let!(:second) { user.expenses.create!(description: "Freela", value: 300) }

        it "returns every expense sorted by id descending" do
            get "/expenses", params: { q: { description_cont: "", s: "id DESC" } }, headers: headers

            expect(response).to have_http_status(200)
            expect(json_body["data"].map { |e| e["id"] }).to eq([second.id.to_s, first.id.to_s])
        end

        it "filters by description" do
            get "/expenses", params: { q: { description_cont: "Free" } }, headers: headers

            expect(json_body["data"].map { |e| e["attributes"]["description"] }).to eq(["Freela"])
        end
    end
end
