class Api::V1::ReportController < ApplicationController

  before_action :set_audition, except: [:result_options]

  def update
    report = @audition.report
    if report.update(report_params)

      if params[:report][:result_id]
        project_id = report.audition.project_id
        Project.find(project_id).update(result_id: params[:report][:result_id])
      end

      render json: @audition, status: :accepted
    end
  end

  def result_options
    render json: Result.all
  end

  def dashboard_update
    report = @audition.report
    if report.update(report_params)
      render json: current_user, serializer: DashboardSerializer, include: ['projects', 'projects.auditions', 'projects.auditions.report','projects.company', 'projects.result'], status: :accepted
    else
      render json: {error: true, message: "Could not update report"}, status: :not_accepted
    end
  end

  private

  def report_params
    params.require(:report).permit(:notes, :people, :auditors)
  end

  def set_audition
    @audition = Audition.find(params[:audition_id])
  end

end
