# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    AppContainer.enable_stubs!
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
