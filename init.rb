config.gem "less"

case Rails.env
when "development"
  # Compile less on every request
  ActionController::Base.before_filter { LessForRails.run }
when "production"
  # Compile less when the application loads
  LessForRails.run(:compress => true)
end