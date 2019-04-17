begin
  # Try to load it so we can assign @_result below if needed.
  require 'test/unit/testresult'
rescue LoadError => ignore
end

module Cucumber #:nodoc:
  module Rails #:nodoc:
    class World < ActionDispatch::IntegrationTest #:nodoc:
      include Rack::Test::Methods
      include ActiveSupport::Testing::SetupAndTeardown if ActiveSupport::Testing.const_defined?('SetupAndTeardown')

      def initialize #:nodoc:
        @_result = Test::Unit::TestResult.new if defined?(Test::Unit::TestResult)
      end

      unless defined?(ActiveRecord::Base)
        # Workaround for projects that don't use ActiveRecord
        def self.fixture_table_names
          []
        end
      end
    end
  end
end

World do
  Cucumber::Rails::World.new
end
