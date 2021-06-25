class Api::V1::UsersController < ApplicationController
  
  
  #GET /api/v1/users
  def index

    if request.headers["token"] == "123"
      users = User.all
      render json: {users: users}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/users/:id
  def show

    if request.headers["token"] == "123"

      if User.where(id: params[:id]).present?
        user = User.find(params[:id])
        render json: {user: user}
      else
        render json: {status: 410, description: "ID not found!"}
      end
      
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #POST /api/v1/users
  def create

    if request.headers["token"] == "123"
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
        render json: {status: 500, description: "Internal Server Error"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #PUT /api/v1/users/:id
  def update

    if request.headers["token"] == "123"

      if User.where(id: params[:id]).present?
        user = User.find(params[:id])
        user.update!(params.require(:user).permit(:name, :email, :password, :password_confirmation, :accounting_id))
        render json: {user: user}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #DELETE /api/v1/users/:id
  def destroy

    if request.headers["token"] == "123"

      if User.where(id: params[:id]).present?
        user = User.delete(params[:id])
        render json: {status: "User has been deleted!"}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end
  

end