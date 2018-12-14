class Api::V1::ReportsController < ApplicationController

  before_action :set_audition

  def create
    if @audition.create_report(report_params)
      render json: @audition.report, status: :created
    end
  end

  private

  def report_params
    params.require(:report).permit(:notes, :people, :auditors, :result_id)
  end

  def set_audition
    @audition = Audition.find(params[:audition_id])
  end

end
