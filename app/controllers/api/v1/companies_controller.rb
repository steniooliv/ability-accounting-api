class Api::V1::CompaniesController < ApplicationController


  #GET /api/v1/companies
  def index

    if request.headers["token"] == ENV['API_TOKEN']
      companies = Company.all
      render json: {companies: companies}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/companies/:id
  def show

    if request.headers["token"] == ENV['API_TOKEN']

      if Company.where(id: params[:id]).present?
        company = Company.find(params[:id])
        render json: {company: company}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #POST /api/v1/companies
  def create

    if request.headers["token"] == ENV['API_TOKEN']

      company = Company.create!(
        name: params["company"]["name"],
        number: params["company"]["number"],
        accounting_id: params["company"]["accounting_id"]
      )

      if company
        render json: {
          status: :created,
          company: company
        }
      else
        render json: {status: 500, description: "Internal Server Error"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #PUT /api/v1/companies/:id
  def update

    if request.headers["token"] == ENV['API_TOKEN']

      if Company.where(id: params[:id]).present?
        company = Company.find(params[:id])
        company.update!(params.require(:company).permit(:name, :number, :accounting_id))
        render json: {company: company}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #DELETE /api/v1/companies/:id
  def destroy

    if request.headers["token"] == ENV['API_TOKEN']

      if Company.where(id: params[:id]).present?
        company = Company.find(params[:id])
        company = company.destroy
        render json: {status: "Company has been deleted."}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


end
