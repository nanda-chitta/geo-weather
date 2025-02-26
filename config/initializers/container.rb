# frozen_string_literal: true

require 'dry/system/container'

class AppContainer < Dry::System::Container
  configure do |config|
    config.root = (Pathname.pwd + 'app')

    config.component_dirs.add 'domain'
  end
end

AppContainer.finalize! if Rails.env.production?
