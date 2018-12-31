class Api::V1::CompaniesController < ApplicationController

  def index
    render json: current_user.companies.order(:name)
  end

  def update
    @company = current_user.companies.find(params[:id])
    if @company.update(company_params)
      render json: @company, status: :accepted
    else
      render json: {error: true, message: "Cannot update Company"}, status: :not_acceptable
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

end
