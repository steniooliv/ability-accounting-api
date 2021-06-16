ActiveAdmin.register Invoice do

  permit_params :customer_id, :company_id, :number, :serie, :model, :type_record, :type_movement, :date_issue, :date_departure, :access_key, :total_product, :discount_value, :expenses_value, :shipping_value, :safe_value, :icms_base, :icms_value, :sticms_base, :sticms_value, :ipi_base, :ipi_value, :pis_base, :pis_value, :cofins_base, :cofins_value, :invoice_value, :invoice_xml

  form do |f|
    f.semantic_errors 
    f.inputs
    f.inputs do
      f.input :invoice_xml, as: :file
    end   
    f.actions 
  end
  
end


