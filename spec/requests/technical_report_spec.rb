require 'rails_helper'

RSpec.describe "Technical Reports", type: :request do
  describe "GET /api/v1/technical_reports" do
    it "returns http success" do
      get "/api/v1/technical_reports"

      expect(response.status).to eq(200)
    end

    it "returns a single technical report" do
      @technical_report = TechnicalReport.new(
        name: "Test User 1",
        device:  "Test Device 1",
        defect: "Test Defect 1",
        description: "Test Description 1"
      )
      @technical_report.save

      expect(TechnicalReport.count).to eq(1)

      get "/api/v1/technical_reports/1"

      expect(response.headers["Content-Type"]).to eq('application/xlsx')
      expect(response.headers["Content-Disposition"]).to eq("attachment; filename=\"technical_report_1.xlsx\"; filename*=UTF-8''technical_report_1.xlsx")
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
