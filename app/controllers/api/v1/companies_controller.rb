class Api::V1::CompaniesController < ApplicationController

  def index
    render json: Company.all
  end

end
