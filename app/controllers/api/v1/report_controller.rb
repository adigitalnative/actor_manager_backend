class Api::V1::ReportController < ApplicationController

  before_action :set_audition, except: [:result_options]

  def create
    if @audition.create_report(report_params)
      render json: @audition, include: ['report', 'report.result'], status: :created
    end
  end

  def update
    report = @audition.report
    if report.update(report_params)
      render json: @audition, include: ['report', 'report.result'], status: :accepted
    end
  end

  def destroy
    report = @audition.report
    report.destroy
    render json: @audition, include: ['report', 'report.result'], status: :accepted
  end

  def result_options
    render json: Result.all
  end

  private

  def report_params
    params.require(:report).permit(:notes, :people, :auditors, :result_id)
  end

  def set_audition
    @audition = Audition.find(params[:audition_id])
  end

end
