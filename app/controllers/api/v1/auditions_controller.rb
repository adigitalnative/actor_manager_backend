class Api::V1::AuditionsController < ApplicationController

  def index
    render json: current_user.auditions
  end

  def create
    params["audition"]["user_id"] = current_user.id
    if params["audition"]["new_project_title"] && params["audition"]["new_company_title"]
      company = Company.create(name: params["audition"]["new_company_title"], user_id: current_user.id)
      project = company.projects.create(name: params["audition"]["new_project_title"],
        user: current_user)
      @audition = project.auditions.new(audition_params)
    elsif params["audition"]["new_project_title"] && params["audition"]["company_id"]
      company = current_user.companies.find(params["audition"]["company_id"])
      project = company.projects.create(name: params["audition"]["new_project_title"],
        user: current_user)
      @audition = project.auditions.new(audition_params)
    elsif params["audition"]["new_project_title"]
      project = Project.create(name: params["audition"]["new_project_title"],
        user: current_user)
      @audition = project.auditions.new(audition_params)
    else
      @audition = Audition.new(audition_params)
    end
    
    if @audition.valid?
      @audition.save
      render json: @audition, status: :created
    else
      render json: {error: true, message: "Audition is not valid"}, status: :not_acceptable
    end
  end

  def update
    @audition = current_user.auditions.find(params[:id])

    if params["audition"]["new_project_title"] && params["audition"]["new_company_title"]
      company = Company.create(name: params["audition"]["new_company_title"], user_id: current_user.id)
      project = company.projects.create(name: params["audition"]["new_project_title"],
        user: current_user)
      params["audition"]["project_id"] = project.id
    elsif params["audition"]["new_project_title"] && params["audition"]["company_id"]
      company = current_user.companies.find(params["audition"]["company_id"])
      project = company.projects.create(name: params["audition"]["new_project_title"],
        user: current_user)
      params["audition"]["project_id"] = project.id
    elsif params["audition"]["new_project_title"]
      project = Project.create(name: params["audition"]["new_project_title"], user: current_user)
      params["audition"]["project_id"] = project.id
    end

    if @audition.update(audition_params)
      render json: @audition, status: :accepted
    else
      render json: {error: true, message: "Could not save audition"}, status: :not_acceptable
    end
  end

  def destroy
    if Audition.exists?(id: params[:id], user_id: current_user.id)
      @audition = Audition.find_by(id: params[:id], user_id: current_user.id)
      @audition.destroy
      render json: @audition, status: :accepted
    else
      render json: {error: true, message: "Could not delete audition"}, status: :not_acceptable
    end
  end

  private

  def audition_params
    params.require(:audition).permit(:bring, :prepare, :project_id, :category_id, :user_id, book_item_ids: [])
  end

end
