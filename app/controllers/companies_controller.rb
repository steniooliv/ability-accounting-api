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

      @companies = Company.all.where(accounting_id: @current_user.accounting_id);

      @current_company = @companies.find(params['id'])
      
      @invoices = Invoice.all.where(company_id: @current_company.id)

      if params['type'] === 'invoicein'
        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'E')
        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer)}
      end

      if params['type'] === 'invoiceout'
        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'S')
        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer)}
      end

      if params['type'] === 'taxcuponout'
        @invoices = @invoices.where(type_record: 'NFCE')
        @invoices = @invoices.where(type_movement: 'S')
        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer)}
      end

    else
      render json: {status: 404}
    end
  end

  def invoice_products
    if session[:user_id]

      @invoice_products = InvoiceProduct.all

      render json: {invoice_products: @invoice_products}

    else
      render json: {status: 404}
    end
  end
  
end