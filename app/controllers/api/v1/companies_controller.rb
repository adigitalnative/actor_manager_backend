class Api::V1::CompaniesController < ApplicationController

  def index
    render json: current_user.companies
  end

end
