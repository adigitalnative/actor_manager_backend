class Api::V1::ReportController < ApplicationController

  before_action :set_audition, except: [:result_options]

  def update
    report = @audition.report
    if report.update(report_params)

      if params[:report][:result_id]
        project_id = report.audition.project_id
        Project.find(project_id).update(result_id: params[:report][:result_id])
      end

      render json: @audition, include: ['report', 'project', 'project.result'], status: :accepted
    end
  end

  def result_options
    render json: Result.all
  end

  private

  def report_params
    params.require(:report).permit(:notes, :people, :auditors)
  end

  def set_audition
    @audition = Audition.find(params[:audition_id])
  end

end
