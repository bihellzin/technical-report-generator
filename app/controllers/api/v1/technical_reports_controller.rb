class Api::V1::TechnicalReportsController < ApplicationController
  def index
    reports = TechnicalReport.all
    render json: { reports: reports }, status: 200
  end
end
