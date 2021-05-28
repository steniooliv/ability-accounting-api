if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: '_authentication_app', domain: 'hm.ls'
else
  Rails.application.config.session_store :cookie_store, key: '_authentication_app'
end