require 'rails_helper'

RSpec.describe 'Expenses API v1', type: :request do
    let!(:user) { create(:user) }
    let(:headers) { { "Accept" => "application/vnd.projetofase8.v1", "Authorization" => user.auth_token } }

    before { host! "localhost:3000/api" }

    describe "GET /expenses" do
        before do
            user.expenses.create!(description: "Aluguel", value: 900, date: Date.new(2026, 10, 10))
            get "/expenses", params: {}, headers: headers
        end

        it "returns status code 200" do
            expect(response).to have_http_status(200)
        end

        it "returns the user's expenses" do
            expect(json_body["expenses"].map { |e| e["description"] }).to eq(["Aluguel"])
        end
    end

    describe "POST /expenses" do
        before do
            post "/expenses", params: { expense: expense_params }, headers: headers
        end

        context "when the request params are valid" do
            let(:expense_params) { { description: "Luz", value: 120.75, date: "2026-10-05" } }

            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end

            it "returns the created expense" do
                expect(json_body["description"]).to eq("Luz")
            end
        end

        context "when the request params are invalid" do
            let(:expense_params) { { description: "" } }

            it "returns status code 422" do
                expect(response).to have_http_status(422)
            end
        end
    end
end
