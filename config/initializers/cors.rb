# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

to_regexp = ->(string) { Regexp.new(string) }

hosts = [
  *ENV.fetch('DEV_ORIGINS').split(','),
  *ENV.fetch('PROD_ORIGINS').split(';').map(&to_regexp)
]

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins(*hosts)

    resource '*',
             headers: :any,
             expose: %w[access-token expiry token-type uid client],
             methods: %i[get post put patch delete options head]
  end
end
