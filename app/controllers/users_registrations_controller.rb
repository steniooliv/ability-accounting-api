class RegistrationsController < ApplicationController

  def create
    user = User.create!(
      name: params['user']['name'],
      email: params['user']['email'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation'],
      accounting_id: params['user']['accounting_id'],
    )

    if user
      session[:user_id] = user.user_id
      render json: {
        status: :created,
        user: user
      }
    else
      render json: {status: 500}
  end
end