ActiveAdmin.register Company do

  permit_params :name, :number, :accounting_id
  
end
