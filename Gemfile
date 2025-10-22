source "https://rubygems.org"

# Rails framework
gem "rails", "~> 8.0.3"

# Database
gem "pg", "~> 1.1"

# Authentication
gem "devise"
gem "devise_token_auth"

# Web server
gem "puma", ">= 5.0"

# Timezone support for Windows
gem "tzinfo-data", platforms: %i[windows jruby]

# Rails caching & background jobs
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Boot speed optimization
gem "bootsnap", require: false

# Deploy anywhere as Docker container
gem "kamal", require: false

# HTTP asset caching/compression for Puma
gem "thruster", require: false

# Optional: Active Storage variants
# gem "image_processing", "~> 1.2"

# Optional: Handle CORS
# gem "rack-cors"

# Development and test gems
group :development, :test do
  # Debugging
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Security scanner
  gem "brakeman", require: false

  # Ruby style guide
  gem "rubocop-rails-omakase", require: false

  # Testing
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end
