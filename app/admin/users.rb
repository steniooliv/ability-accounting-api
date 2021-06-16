ActiveAdmin.register User do


  permit_params :name, :email, :password, :password_confirmation, :accounting_id

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :accounting_id,  :as => :select,      :collection => Accounting.all
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions 
  end

  
end
