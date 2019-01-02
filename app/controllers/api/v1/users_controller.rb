class Api::V1::UsersController < ApplicationController

  skip_before_action :authorized, only: :create

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), token: @token, include: ['states'] }, status: :created
    else
      render json: { error: true, message: "Failed to create user"}, status: :not_acceptable
    end
  end

  def update
    params[:user][:state_ids] = set_audition_states(params[:user][:audition_states])
    if @user.update(user_params)
      render json: @user, include: ['states'], status: :accepted
    else
      render json: {error: true, message: "Invalid entry"}, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, state_ids: [])
  end

  def set_audition_states(states_array)
    if states_array.count < 0 || (states_array.count == 1 && states_array[0] == "")
      return []
    else
      states_array.map do |state|
        State.find_by_name(state).id
      end
    end
  end

end
