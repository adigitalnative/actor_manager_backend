class Api::V1::OpportunitiesController < ApplicationController

  def index
    Lead.generate_for(current_user)
    render json: current_user.leads
  end

  def toggle_archived
    lead_to_archive = current_user.leads.find_by(opportunity_id: params[:opportunity_id])
    if lead_to_archive.update(archived: !lead_to_archive.archived?)
      render json: lead_to_archive, status: :accepted
    else
      render json: {error: true, message: "Could not archive the lead"}
    end
  end

end
