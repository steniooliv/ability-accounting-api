ActiveAdmin.register Invoice do

  permit_params :number, :serie, :total_value, :company_id, :customer_id, :invoice_xml

  form do |f|
    f.semantic_errors 
    f.inputs
    f.inputs do
      f.input :invoice_xml, as: :file
    end   
    f.actions 
  end
  
end


