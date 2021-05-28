if Rails.env == "production"
  Rails.application.config.session_store
    :cookie_store,
    key: '_authentication_app',
    secure: Rails.env.production?,
    ttponly: true,
    domain: :all,
    expire_after: 14.days
else
  Rails.application.config.session_store :cookie_store, key: '_authentication_app'
end