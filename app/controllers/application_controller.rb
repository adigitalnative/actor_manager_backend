class ApplicationController < ActionController::API

  def index
    render json: Category.all
  end

end
