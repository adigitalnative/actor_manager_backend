class Api::V1::AuthController < ApplicationController

  skip_before_action :authorized, only: [:create, :authorize_token]

  def create
    @user = User.find_by(email: user_login_params[:email])
    if @user && @user.authenticate(user_login_params[:password])
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(@user), token: token, include: ['states'] }, status: :accepted
    else
      render json: { message: 'Invalid email or password', error: true }, status: :unauthorized
    end
  end

  def authorize_token
    if current_user
      token = encode_token({ user_id: @user.id })
      render json: { user: UserSerializer.new(current_user), token: token, include: ['states']}, status: :accepted
    else
      render json: { message: "Invalid token", error: true}, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end


end
