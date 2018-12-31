class Api::V1::ProjectsController < ApplicationController

  def index
    render json: current_user.projects.order(:name)
  end

  def update
    project = current_user.projects.find(params[:id])
    if project.update(project_params)
      render json: project.company, status: :accepted
    else
      render json: {error: true, message: "Project could not be updated"}, status: :not_acceptable
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :result_id)
  end

end
