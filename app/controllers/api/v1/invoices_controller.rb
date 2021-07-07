class Api::V1::InvoicesController < ApplicationController


  #GET /api/v1/invoices
  def index

    if request.headers["token"] == ENV['API_TOKEN']
      invoices = Invoice.all
      render json: {invoices: invoices}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/invoices/:id
  def show

    if request.headers["token"] == ENV['API_TOKEN']

      if Invoice.where(id: params[:id]).present?
        invoice = Invoice.find(params[:id])
        render json: {invoice: invoice}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #POST /api/v1/invoices
  def create

    if request.headers["token"] == ENV['API_TOKEN']

      invoice = Invoice.create!(
        number: params["invoice"]["number"],
        serie: params["invoice"]["serie"],
        model: params["invoice"]["model"],
        status: params["invoice"]["status"],
        type_record: params["invoice"]["type_record"],
        type_movement: params["invoice"]["type_movement"],
        date_issue: params["invoice"]["date_issue"],
        date_departure: params["invoice"]["date_departure"],
        access_key: params["invoice"]["access_key"],
        total_product: params["invoice"]["total_product"],
        discount_value: params["invoice"]["discount_value"],
        expenses_value: params["invoice"]["expenses_value"],
        shipping_value: params["invoice"]["shipping_value"],
        safe_value: params["invoice"]["safe_value"],
        icms_base: params["invoice"]["icms_base"],
        icms_value: params["invoice"]["icms_value"],
        sticms_base: params["invoice"]["sticms_base"],
        sticms_value: params["invoice"]["sticms_value"],
        ipi_base: params["invoice"]["ipi_base"],
        ipi_value: params["invoice"]["ipi_value"],
        pis_base: params["invoice"]["pis_base"],
        pis_value: params["invoice"]["pis_value"],
        cofins_base: params["invoice"]["cofins_base"],
        cofins_value: params["invoice"]["cofins_value"],
        invoice_value: params["invoice"]["invoice_value"],
        customer_id: params["invoice"]["customer_id"],
        company_id: params["invoice"]["company_id"],
      )

      if invoice
        render json: {
          status: :created,
          invoice: invoice
        }
      else
        render json: {status: 500, description: "Internal Server Error"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #PUT /api/v1/invoices/:id
  def update

    if request.headers["token"] == ENV['API_TOKEN']

      if Invoice.where(id: params[:id]).present?
        invoice = Invoice.find(params[:id])
        invoice.update!(params.require(:invoice).permit(:number, :serie, :model, :status, :type_record, :type_movement, :date_issue, :date_departure, :access_key, :total_product, :discount_value, :expenses_value, :shipping_value, :safe_value, :icms_base, :icms_value, :sticms_base, :sticms_value, :ipi_base, :ipi_value, :pis_base, :pis_value, :cofins_base, :cofins_value, :invoice_value, :customer_id, :company_id))
        render json: {invoice: invoice}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #DELETE /api/v1/invoices/:id
  def destroy

    if request.headers["token"] == ENV['API_TOKEN']

      if Invoice.where(id: params[:id]).present?
        invoice = Invoice.find(params[:id])
        invoice = invoice.destroy
        render json: {status: "Invoice has been deleted."}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


end