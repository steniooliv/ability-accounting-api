class CompaniesController < ApplicationController
  
  include CurrentUserConcern

   def index
    @companies = Company.all

    @companies = @companies.where(accounting_id: @current_user.accounting_id);

    render json: {
      companies: @companies
    }
  end

  def invoices
    if session[:user_id]

      @companies = Company.all
      @companies = @companies.where(accounting_id: @current_user.accounting_id);

      @current_company = @companies.find(params['id'])

      @invoices = Invoice.all
      @invoices = @invoices.where(company_id: @current_company.id)

      render json: {invoices: @invoices, @current_company}
    else
      render json: {status: 404}
    end
  end
  
end