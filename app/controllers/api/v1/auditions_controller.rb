class Api::V1::AuditionsController < ApplicationController

  def index
    render json: Audition.all
  end

  def create
    @audition = Audition.new(audition_params)
    if @audition.valid?
      @audition.save
      render json: @audition, status: :created
    else
      render json: {error: true, message: "Audition is not valid"}, status: :not_acceptable
    end
  end

  def update
    @audition = Audition.find(params[:id])
    if @audition.update(audition_params)
      render json: @audition, status: :accepted
    else
      render json: {error: true, message: "Could not save audition"}, status: :not_acceptable
    end
  end

  def destroy
    if Audition.exists?(id: params[:id])
      @audition = Audition.find(params[:id])
      @audition.destroy
      render json: @audition, status: :accepted
    else
      render json: {error: true, message: "Could not delete audition"}, status: :not_acceptable
    end
  end

  private

  def audition_params
    params.require(:audition).permit(:bring, :prepare)
  end

end
