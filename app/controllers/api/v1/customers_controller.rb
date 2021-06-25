class Api::V1::CustomersController < ApplicationController


  #GET /api/v1/customers
  def index

    if request.headers["token"] == ENV['API_TOKEN']
      customers = Customer.all
      render json: {customers: customers}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/customers/:id
  def show

    if request.headers["token"] == ENV['API_TOKEN']

      if Customer.where(id: params[:id]).present?
        customer = Customer.find(params[:id])
        render json: {customer: customer}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #POST /api/v1/customers
  def create

    if request.headers["token"] == ENV['API_TOKEN']

      customer = Customer.create!(
        name: params["customer"]["name"],
        number: params["customer"]["number"],
      )

      if customer
        render json: {
          status: :created,
          customer: customer
        }
      else
        render json: {status: 500, description: "Internal Server Error"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #PUT /api/v1/customers/:id
  def update

    if request.headers["token"] == ENV['API_TOKEN']

      if Customer.where(id: params[:id]).present?
        customer = Customer.find(params[:id])
        customer.update!(params.require(:customer).permit(:name, :number))
        render json: {customer: customer}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #DELETE /api/v1/customers/:id
  def destroy

    if request.headers["token"] == ENV['API_TOKEN']

      if Customer.where(id: params[:id]).present?
        customer = Customer.find(params[:id])
        customer = customer.destroy
        render json: {status: "Customer has been deleted."}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


end