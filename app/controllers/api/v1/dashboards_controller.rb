class Api::V1::DashboardsController < ApplicationController

  def show
    render json: current_user, serializer: DashboardSerializer, include: ['projects', 'projects.auditions', 'projects.company', 'projects.result']
  end

end
