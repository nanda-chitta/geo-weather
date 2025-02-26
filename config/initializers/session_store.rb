# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

if Rails.application.config.cache_store == :redis_cache_store
  servers = { host: ENV.fetch('REDIS_HOST', nil), namespace: 'sessions' }
  Rails.application.config.session_store(:cache_store, servers: servers, expires_in: 24.hours)
else
  Rails.application.config.session_store :active_record_store, key: '_GEO_WEATHER_API_SESSION'
end
