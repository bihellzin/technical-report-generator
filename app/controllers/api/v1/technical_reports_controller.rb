require 'axlsx'

class Api::V1::TechnicalReportsController < ApplicationController
  def index
    reports = TechnicalReport.all
    render json: { reports: reports }, status: 200
  end

  def show
    @technical_report = TechnicalReport.find(params[:id])
    p = Axlsx::Package.new
    wb = p.workbook
    wb.add_worksheet(:name => "Technical Report") do |sheet|
      sheet.add_row ["Name", "Device", "Defect", "Description"]
      sheet.add_row [
        @technical_report.name,
        @technical_report.device,
        @technical_report.defect,
        @technical_report.description
      ]
    end

    send_data p.to_stream.read, type: "application/xlsx", filename: "technical_report_#{params[:id]}.xlsx"
  end

  def create
    @technical_report = TechnicalReport.new(technical_report_params)

    if @technical_report.save
      render json: @technical_report, status: :created
    else
      render json: @technical_report.errors, status: :unprocessable_entity
    end
  end

  private

  def technical_report_params
    params.require(:technical_report).permit(:name, :device, :defect, :description)
  end
end
