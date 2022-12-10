class Api::V1::TechnicalReportsController < ApplicationController
  def index
    reports = TechnicalReport.all
    render json: { message: "hello", reports: reports }
  end
end
