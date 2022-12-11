require 'rails_helper'

RSpec.describe TechnicalReport, type: :model do
  it "is a valid technical report when name, device, defect and description are present" do
    technical_report = TechnicalReport.new(name: "John Doe",
    device: "iPhone 11",
    defect: "Broken display",
    description: "Change display")

    expect(technical_report).to be_valid
  end
  it "is not valid when one of the fields is not present" do
    technical_report = TechnicalReport.new(name: "John Doe",
    device: "iPhone 11",
    defect: "Broken display")
    technical_report.valid?
    expect(technical_report.errors[:description]).to include("can't be blank")
  end
end
