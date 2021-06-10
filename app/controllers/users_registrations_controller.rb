class UsersRegistrationsController < ApplicationController

  def create
    user = User.create!(
      name: params['user']['name'],
      email: params['user']['email'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation'],
      accounting_id: params['user']['accounting_id'],
    )

    if user
      session[:user_id] = user.id
      render json: {
        status: :created,
        user: user
      }
    else
      render json: {status: 500}
    end
  end

  # def show
  #   user = User.find(params[:id])

  #   if user.id
  #     render json: {user: user}
  #   else
  #     render json: {status: 404}
  #   end

  # end

  # def index
  #   @users = User.all
  #   render json: {users: @users}
  # end

  # def update
  #   user = User.find(params[:id])
  #   user.update!(params.require(:user).permit(:name, :email, :password, :password_confirmation, :accounting_id))

  # end

  # def destroy
  #   user = User.delete(params[:id])
  # end
  
end