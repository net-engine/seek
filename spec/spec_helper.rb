$:.push File.expand_path('../../lib', __FILE__)
require 'seek'
require 'pry'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
