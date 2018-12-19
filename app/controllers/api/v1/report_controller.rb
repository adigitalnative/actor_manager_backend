class Api::V1::ReportController < ApplicationController

  before_action :set_audition, except: [:result_options]

<<<<<<< HEAD
=======
  def create
    if @audition.create_report(report_params)
      render json: @audition, include: ['report', 'project', 'project.result'], status: :created
    end
  end

>>>>>>> ResultMove: WIP
  def update
    report = @audition.report
    if report.update(report_params)
      render json: @audition, include: ['report', 'project', 'project.result'], status: :accepted
    end
  end

<<<<<<< HEAD
=======
  def destroy
    report = @audition.report
    report.destroy
    render json: @audition, include: ['report', 'project', 'project.result'], status: :accepted
  end

>>>>>>> ResultMove: WIP
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
