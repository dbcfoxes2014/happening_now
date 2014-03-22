require 'coveralls'
Coveralls.wear!('rails')

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require "capybara/rails"
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.include Capybara::DSL

  config.mock_with :rspec

  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerMacros, :type => :controller
  config.include RequestMacros, :type => :request

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Include Factory Girl syntax to simplify calls to factories 
  config.include FactoryGirl::Syntax::Methods

  # Test::Unit
  class Test::Unit::TestCase
    include FactoryGirl::Syntax::Methods
  end

  # Cucumber
  FactoryGirl::Syntax::Methods
  
  # # Spinach
  # class Spinach::FeatureSteps
  #   include FactoryGirl::Syntax::Methods
  # end

  # MiniTest
  class MiniTest::Unit::TestCase
    include FactoryGirl::Syntax::Methods
  end

  # MiniTest::Spec
  class MiniTest::Spec
    include FactoryGirl::Syntax::Methods
  end

  # minitest-rails
  class MiniTest::Rails::ActiveSupport::TestCase
    include FactoryGirl::Syntax::Methods
  end

end