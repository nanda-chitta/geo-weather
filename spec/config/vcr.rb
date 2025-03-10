# frozen_string_literal: true

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('spec/fixtures/vcr_cassettes')
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :new_episodes }
  c.ignore_localhost = false
end
