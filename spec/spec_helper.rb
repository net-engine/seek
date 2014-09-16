$:.push File.expand_path('../../lib', __FILE__)
require 'seek'
require 'pry'

Dir[File.expand_path('../../spec/macros/*.rb', __FILE__)].each { |f| require f }

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.include Macros
end
