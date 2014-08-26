# Be sure to restart your server when you modify this file.

#Cms::Application.config.session_store :cookie_store, key: '_cms_session'
require 'action_dispatch/middleware/session/dalli_store'
Cms::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 30.minutes, username: 'admin', password: ENV['MEMCACHED_PASS']

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Cms::Application.config.session_store :active_record_store
