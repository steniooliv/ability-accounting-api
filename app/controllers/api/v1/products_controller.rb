class Api::V1::ProductsController < ApplicationController

  before_action :get_invoice


  #GET /api/v1/invoices/:id/products
  def index

    if request.headers["token"] == ENV['API_TOKEN']
      products = InvoiceProduct.all.where(invoice_id: @invoice.id)
      render json: {products: products}
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end



  #GET /api/v1/invoices/:id/products/id:
  def show
    
    if request.headers["token"] == ENV['API_TOKEN']
      products = InvoiceProduct.all.where(invoice_id: @invoice.id)

      if products.where(id: params[:id]).present?
        product = products.find(params[:id])
        render json: {product: product}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/invoices/:id/products
  def create

    if request.headers["token"] == ENV['API_TOKEN']
      
      product = InvoiceProduct.create!(
        product_id: params["product"]["product_id"],
        description: params["product"]["description"],
        ncm: params["product"]["ncm"],
        cfop: params["product"]["cfop"],
        cest: params["product"]["cest"],
        quantity: params["product"]["quantity"],
        price_unitary: params["product"]["price_unitary"],
        price_total: params["product"]["price_total"],
        discount_value: params["product"]["discount_value"],
        expenses_value: params["product"]["expenses_value"],
        shipping_value: params["product"]["shipping_value"],
        safe_value: params["product"]["safe_value"],
        icms_cst_csosn: params["product"]["icms_cst_csosn"],
        icms_base: params["product"]["icms_base"],
        icms_value: params["product"]["icms_value"],
        icms_free_value: params["product"]["icms_free_value"],
        icms_other_value: params["product"]["icms_other_value"],
        sticms_base: params["product"]["sticms_base"],
        sticms_value: params["product"]["sticms_value"],
        ipi_cst: params["product"]["ipi_cst"],
        ipi_base: params["product"]["ipi_base"],
        ipi_value: params["product"]["ipi_value"],
        pis_cst: params["product"]["pis_cst"],
        pis_base: params["product"]["pis_base"],
        pis_value: params["product"]["pis_value"],
        cofins_cst: params["product"]["cofins_cst"],
        cofins_base: params["product"]["cofins_base"],
        cofins_value: params["product"]["cofins_value"],
        invoice_id: params["product"]["invoice_id"],
      )
      
      if product
        render json: {
          status: :created,
          product: product
        }
      else
        render json: {status: 500, description: "Internal Server Error"}
      end
    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end


  #GET /api/v1/invoices/:id/products/:id
  def update

    if request.headers["token"] == ENV['API_TOKEN']
      products = InvoiceProduct.all.where(invoice_id: @invoice.id)

      if products.where(id: params[:id]).present?
        product = products.find(params[:id])
        product.update!(params.require(:product).permit(:product_id, :description, :ncm, :cfop, :cest, :quantity, :price_unitary, :price_total, :discount_value, :expenses_value, :shipping_value, :safe_value, :icms_cst_csosn, :icms_base, :icms_value, :icms_free_value, :icms_other_value, :sticms_base, :sticms_value, :ipi_cst, :ipi_base, :ipi_value, :pis_cst, :pis_base, :pis_value, :cofins_cst, :cofins_base, :cofins_value, :invoice_id))
        render json: {product: product}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end

  end

  
  #GET /api/v1/invoices/:id/products/:id
  def destroy

    if request.headers["token"] == ENV['API_TOKEN']
      products = InvoiceProduct.all.where(invoice_id: @invoice.id)

      if products.where(id: params[:id]).present?
        product = products.find(params[:id])
        product = product.destroy
        render json: {status: "Product has been deleted."}
      else
        render json: {status: 410, description: "ID not found!"}
      end

    else
      render json: {status: 401, description: "Unauthorized"}
    end


  end


  
  
  private

  def get_invoice
    if Invoice.all.where(id: params[:invoice_id]).present?
      @invoice = Invoice.find(params[:invoice_id])
    else
      render json: {status: 410, description: "ID not found!"}
    end
  end


end