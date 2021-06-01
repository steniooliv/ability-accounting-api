class CompaniesController < ApplicationController
  
  include CurrentUserConcern

   def index
    @companies = Company.all

    @companies = @companies.where(accounting_id: @current_user.accounting_id);

    render json: {
      companies: @companies
    }
  end
  
end