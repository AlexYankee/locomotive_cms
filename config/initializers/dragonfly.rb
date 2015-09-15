require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "907593f1a9b98002b74e27e4581b51d6136c6c18ee3586f195e73d3b1a74eb95"

  url_format '/images/dynamic/:job/:basename.:format'

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
