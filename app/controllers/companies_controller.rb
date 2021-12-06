class CompaniesController < ApplicationController

  require 'json'
  
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

      start_params = params['start_date']
      start_date = start_params.to_date
      
      end_params = params['end_date']
      end_date = end_params.to_date

      if params['type'] === 'invoicein'
        @invoices = @invoices.where(date_departure: start_date...end_date)
        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'E')
        @invoice_products = InvoiceProduct.all.where(invoice_id: @invoices.ids)
        
        @invoices = @invoices.order(date_departure: :asc, date_issue: :asc, number: :asc)

        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer), products: @invoice_products}
      end

      if params['type'] === 'invoiceout'
        @invoices = @invoices.where(date_issue: start_date...end_date)
        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'S')
        @invoice_products = InvoiceProduct.all.where(invoice_id: @invoices.ids)

        @invoices = @invoices.order(date_issue: :asc, date_departure: :asc, number: :asc)

        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer), products: @invoice_products}
      end

      if params['type'] === 'taxcuponout'
        @invoices = @invoices.where(date_issue: start_date...end_date)
        @invoices = @invoices.where(type_record: 'NFCE')
        @invoices = @invoices.where(type_movement: 'S')
        @invoice_products = InvoiceProduct.all.where(invoice_id: @invoices.ids)

        @invoices = @invoices.order(date_issue: :asc, date_departure: :asc, number: :asc)

        render json: {company: @current_company, invoices: @invoices.as_json(include: :customer), products: @invoice_products}
      end

    else
      render json: {status: 404}
    end
  end

  def invoice_products
    if session[:user_id]

      @companies = Company.all.where(accounting_id: @current_user.accounting_id);

      @current_company = @companies.find(params['id'])
      
      @invoices = Invoice.all.where(company_id: @current_company.id)

      start_params = params['start_date']
      start_date = start_params.to_date
      
      end_params = params['end_date']
      end_date = end_params.to_date


      if params['type'] === 'invoicein'
        @invoices = @invoices.where(date_departure: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'E')

        @invoices = @invoices.order(date_departure: :asc)

      end

      if params['type'] === 'invoiceout'
        @invoices = @invoices.where(date_issue: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'S')

        @invoices = @invoices.order(date_issue: :asc)

      end

      if params['type'] === 'taxcuponout'
        @invoices = @invoices.where(date_issue: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFCE')
        @invoices = @invoices.where(type_movement: 'S')

        @invoices = @invoices.order(date_issue: :asc)

      end

      @invoice_products = InvoiceProduct.all.where(invoice_id: @invoices.ids)

      @cfop_products = @invoice_products
                            .order(icms_cst_csosn: :asc, cfop: :asc)
                            .group(:icms_cst_csosn, :cfop)
                            .select(:icms_cst_csosn,
                              "SUM(price_total) + SUM(ipi_value) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) + SUM(sticms_value) - SUM(discount_value) as total_accounting",
                              "SUM(icms_base) as total_icms_base",
                              "SUM(icms_value) as total_icms_value",
                              "SUM(icms_free_value) as total_icms_free_value",
                              "SUM(icms_other_value) as total_icms_other_value",
                              :cfop
                            )
                            .collect{
                                |invoice_products| {
                                  icms_cst_csosn: invoice_products.icms_cst_csosn,
                                  cfop: invoice_products.cfop,
                                  total_accounting: invoice_products.total_accounting,
                                  total_icms_base: invoice_products.total_icms_base,
                                  total_icms_value: invoice_products.total_icms_value,
                                  total_icms_free_value: invoice_products.total_icms_free_value,
                                  total_icms_other_value: invoice_products.total_icms_other_value
                                }
                            }

      @cfop_total_values = @invoice_products
                              .select(
                                "SUM(price_total) + SUM(ipi_value) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) + SUM(sticms_value) - SUM(discount_value) as total_total_accounting",
                                "SUM(icms_base) as total_total_icms_base",
                                "SUM(icms_value) as total_total_icms_value",
                                "SUM(icms_free_value) as total_total_icms_free_value",
                                "SUM(icms_other_value) as total_total_icms_other_value"
                              )
                              .collect {
                                |cfop_total| { 
                                  total_total_accounting: cfop_total.total_total_accounting,
                                  total_total_icms_base: cfop_total.total_total_icms_base,
                                  total_total_icms_value: cfop_total.total_total_icms_value,
                                  total_total_icms_free_value: cfop_total.total_total_icms_free_value,
                                  total_total_icms_other_value: cfop_total.total_total_icms_other_value
                                }
                              }

      render json: {cfop_products: @cfop_products, products: @invoice_products, cfop_total: @cfop_total_values}

    else
      render json: {status: 404}
    end
  end

  def pis_cofins
    if session[:user_id]

      @companies = Company.all.where(accounting_id: @current_user.accounting_id);

      @current_company = @companies.find(params['id'])
      
      @invoices = Invoice.all.where(company_id: @current_company.id)

      start_params = params['start_date']
      start_date = start_params.to_date
      
      end_params = params['end_date']
      end_date = end_params.to_date


      if params['type'] === 'invoicein'
        @invoices = @invoices.where(date_departure: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'E')
      end

      if params['type'] === 'invoiceout'
        @invoices = @invoices.where(date_issue: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFE')
        @invoices = @invoices.where(type_movement: 'S')
      end

      if params['type'] === 'taxcuponout'
        @invoices = @invoices.where(date_issue: start_date...end_date)

        @invoices = @invoices.where(type_record: 'NFCE')
        @invoices = @invoices.where(type_movement: 'S')
      end

      @invoice_products = InvoiceProduct.all.where(invoice_id: @invoices.ids)

      if params['check'] === 'PIS'
        @pis_products = @invoice_products
                              .order(pis_cst: :asc)
                              .group(:pis_cst)
                              .select(:pis_cst,
                                "SUM(price_total) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) as total_accounting",
                                "SUM(pis_base) as total_pis_base",
                                "SUM(pis_value) as total_pis_value",
                              )
                              .collect{
                                  |invoice_products| {
                                    pis_cst: invoice_products.pis_cst,
                                    total_accounting: invoice_products.total_accounting,
                                    total_pis_base: invoice_products.total_pis_base,
                                    total_pis_value: invoice_products.total_pis_value,
                                  }
                              }

        @pis_total_values = @invoice_products
                              .select(
                                "SUM(price_total) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) as total_total_accounting",
                                "SUM(pis_base) as total_total_pis_base",
                                "SUM(pis_value) as total_total_pis_value",
                              )
                              .collect {
                                |pis_total| { 
                                  total_total_accounting: pis_total.total_total_accounting,
                                  total_total_pis_base: pis_total.total_total_pis_base,
                                  total_total_pis_value: pis_total.total_total_pis_value,
                                }
                              }

        render json: {pis_products: @pis_products, pis_total: @pis_total_values}

      end

      if params['check'] === 'COFINS'
        @cofins_products = @invoice_products
                              .order(cofins_cst: :asc)
                              .group(:cofins_cst)
                              .select(:cofins_cst,
                                "SUM(price_total) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) as total_accounting",
                                "SUM(cofins_base) as total_cofins_base",
                                "SUM(cofins_value) as total_cofins_value",
                              )
                              .collect{
                                  |invoice_products| {
                                    cofins_cst: invoice_products.cofins_cst,
                                    total_accounting: invoice_products.total_accounting,
                                    total_cofins_base: invoice_products.total_cofins_base,
                                    total_cofins_value: invoice_products.total_cofins_value,
                                  }
                              }
        @cofins_total_values = @invoice_products
                              .select(
                                "SUM(price_total) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) as total_total_accounting",
                                "SUM(cofins_base) as total_total_cofins_base",
                                "SUM(cofins_value) as total_total_cofins_value",
                              )
                              .collect {
                                |cofins_total| { 
                                  total_total_accounting: cofins_total.total_total_accounting,
                                  total_total_cofins_base: cofins_total.total_total_cofins_base,
                                  total_total_cofins_value: cofins_total.total_total_cofins_value,
                                }
                              }

        render json: {cofins_products: @cofins_products, cofins_total: @cofins_total_values}
      end

    else
      render json: {status: 404}
    end
  end

  def cfop_products
    if session[:user_id]
      invoice_id = params['invoice_id']
     
      @invoice_products = InvoiceProduct.all.where(invoice_id: invoice_id)

      @cfop_products = @invoice_products
                              .order(icms_cst_csosn: :asc, cfop: :asc)
                              .group(:icms_cst_csosn, :cfop)
                              .select(:icms_cst_csosn,
                                "SUM(price_total) + SUM(ipi_value) + SUM(expenses_value) + SUM(shipping_value) + SUM(safe_value) + SUM(sticms_value) - SUM(discount_value) as total_accounting",
                                "SUM(icms_base) as total_icms_base",
                                "SUM(icms_value) as total_icms_value",
                                "SUM(icms_free_value) as total_icms_free_value",
                                "SUM(icms_other_value) as total_icms_other_value",
                                :cfop
                              )
                              .collect{
                                  |invoice_products| {
                                    icms_cst_csosn: invoice_products.icms_cst_csosn,
                                    cfop: invoice_products.cfop,
                                    total_accounting: invoice_products.total_accounting,
                                    total_icms_base: invoice_products.total_icms_base,
                                    total_icms_value: invoice_products.total_icms_value,
                                    total_icms_free_value: invoice_products.total_icms_free_value,
                                    total_icms_other_value: invoice_products.total_icms_other_value
                                  }
                              }
      render json: @cfop_products

    else
      render json: {status: 404}
    end
  end

end