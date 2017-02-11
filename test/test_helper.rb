ENV['RAILS_ENV'] ||= 'test'
require 'coveralls'
Coveralls.wear!
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'simplecov'
SimpleCov.start

<<<<<<< HEAD
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

=======
>>>>>>> 09b8924cd443d4dc6117cf56a9ade4eb939f2248
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
