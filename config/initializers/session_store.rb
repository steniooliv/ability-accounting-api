Rails.application.config.session_store :cookie_store, key: '_ability_app', domain: :all, tld_length: 2
Rails.application.config.action_dispatch.cookies_serializer = :json
Rails.application.config.secret_token = 'abaccapp'