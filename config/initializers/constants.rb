# frozen_string_literal: true

LOCATION_FORMAT = /^[a-zA-Z0-9]+(?:[\s-][a-zA-Z0-9]+)*$/.freeze
ADDRESS_FORMAT = /^[a-zA-Z0-9,\s-]+(?:[\s-][a-zA-Z0-9]+)*$/.freeze
ZIP_CODE_FORMAT = /\A[a-zA-Z0-9]+\z/.freeze
COUNTRY_CODE_FORMAT = /^[A-Z]{2}$/.freeze
DATE_FORMAT = %r{\d{2}/\d{2}/\d{4}}.freeze

DEFAULT_LOCATION = 'Mumbai, IN'

WEATHER_API_URL = 'https://api.openweathermap.org'
WEATHER_API_KEY = 'e0252f5c0e218ca79da23c1071d66bca'
