require 'rails_helper'

RSpec.describe "Technical Reports", type: :request do
  describe "GET /api/v1/technical_reports" do
    it "returns http success" do
      # this will perform a GET request to the /health/index route
      get "/api/v1/technical_reports"

      # 'response' is a special object which contain HTTP response received after a request is sent
      # response.body is the body of the HTTP response, which here contain a JSON string
    #   expect(response.body).to eq('{"status":"online"}')

      # we can also check the http status of the response
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/v1/technical_reports" do
    it "should create if all required params are present" do
      post "/api/v1/technical_reports", params: {
        technical_report: {
          name: "Test User",
          device:  "Test Device",
          defect: "Test Defect",
          description: "Test Description"
        }
      }

      expect(response.status).to eq(201)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:name]).to eq("Test User")
      expect(json[:device]).to eq("Test Device")
      expect(json[:defect]).to eq("Test Defect")
      expect(json[:description]).to eq("Test Description")

      expect(TechnicalReport.count).to eq(1)

      expect(TechnicalReport.last.name).to eq("Test User")
    end

    it "should not create if one required params is not present" do
      post "/api/v1/technical_reports", params: {
        technical_report: {
          name: "",
          device:  "Test Device",
          defect: "Test Defect",
          description: "Test Description"
        }
      }

      expect(response.status).to eq(422)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:name]).to eq(["can't be blank"])
      expect(TechnicalReport.count).to eq(0)
    end
  end
end