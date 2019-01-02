class Api::V1::OpportunitiesController < ApplicationController

  def index
    Lead.generate_for(current_user)
    render json: current_user.leads
  end
end
