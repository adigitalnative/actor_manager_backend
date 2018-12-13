class Api::V1::UsersController < ApplicationController

  skip_before_action :authorized, only: :create

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: true, message: "Failed to create user"}, status: :not_acceptable
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end
end
