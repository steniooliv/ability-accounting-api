class Api::V1::AccountingsController < ApplicationController


  #GET /api/v1/accountings
  def index

    if request.headers["token"] == "123"
      accounting = Accounting.all
      render json: {accountings: accounting}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end
  

  #GET /api/v1/accountings/:id
  def show

    if request.headers["token"] == "123"

      if Accounting.where(id: params[:id]).present?
        accounting = Accounting.find(params[:id])
        render json: {accounting: accounting}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end
  

  #POST //api/v1/accountings
  def create

    if request.headers["token"] == "123"
      
      accounting = Accounting.create!(
        name: params["accounting"]["name"],
      )

      if accounting
        render json: {
          status: :created,
          accounting: accounting
        }
      else
        render json: {status: 500, description: "Internal Server Error"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #PUT //api/v1/accountings/:id
  def update

    if request.headers["token"] == "123"

      if Accounting.where(id: params[:id]).present?
        accounting = Accounting.find(params[:id])
        accounting.update!(params.require(:accounting).permit(:name))
        render json: {accounting: accounting}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #DELETE /api/v1/accountings/:id
  def destroy

    if request.headers["token"] == "123"

      if Accounting.where(id: params[:id]).present?
        accounting = Accounting.find(params[:id])
        accounting = accounting.destroy
        render json: {status: "Accounting has been deleted."}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


end
