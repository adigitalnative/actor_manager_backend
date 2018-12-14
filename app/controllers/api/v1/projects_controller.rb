class Api::V1::ProjectsController < ApplicationController

  def index
    render json: current_user.projects
  end

end
