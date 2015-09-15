# Be sure to restart your server when you modify this file.

#Cms::Application.config.session_store :cookie_store, key: '_cms_session'
Cms::Application.config.session_store :redis_store, :expires_in => 90.minutes, servers: "redis://#{ENV['REDIS_PORT_6379_TCP_ADDR']}:6379/0/cache"

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Cms::Application.config.session_store :active_record_store
