# Specify cookies SameSite protection level: either :none, :lax, or :strict.
# This change is not backwards compatible with earlier Rails versions. 
# It's best enabled when your entire app is migrated and stable on 6.1.
# Was not in Rails 6.0. Default in rails 6.1 is :lax, not :strict

Rails.application.config.action_dispatch.cookies_same_site_protection = :none 
