class Api::V1::TechnicalReportsController < ApplicationController
  def index
    reports = TechnicalReport.all
    render json: { reports: reports }, status: 200
  end

  def create
    puts technical_report_params
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
