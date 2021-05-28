if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, :same_site :none, key: '_authentication_app', domain: :all
else
  Rails.application.config.session_store :cookie_store, key: '_authentication_app'
end