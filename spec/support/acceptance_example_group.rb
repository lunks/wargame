module AcceptanceExampleGroup
  extend ActiveSupport::Concern

  include RSpec::Rails::RequestExampleGroup
  include Rack::Test::Methods

  included do
    metadata[:type] = :acceptance
  end
end

