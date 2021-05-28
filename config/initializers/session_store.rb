if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: '_authentication_app', domain: '172.29.91.153'
else
  Rails.application.config.session_store :cookie_store, key: '_authentication_app'
end

