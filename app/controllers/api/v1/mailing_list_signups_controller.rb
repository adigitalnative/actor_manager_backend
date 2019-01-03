class Api::V1::MailingListSignupsController < ApplicationController
  skip_before_action :authorized

  def create
    @signup = MailingListSignup.new(mailing_list_signup_params)
    if @signup.save
      render json: { created: true}, status: :created
    else
      render json: {error: true, message: "Couldn't sign you up"}, status: :not_acceptable
    end
  end

  private

  def mailing_list_signup_params
    params.require(:mailing_list_signup).permit(:email)
  end

end
