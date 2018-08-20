require 'rspec/core'

require 'rails_authorize/matchers/forbid_action'
require 'rails_authorize/matchers/forbid_actions'
require 'rails_authorize/matchers/forbid_mass_assignment_of'
require 'rails_authorize/matchers/permit_action'
require 'rails_authorize/matchers/permit_actions'
require 'rails_authorize/matchers/permit_mass_assignment_of'

module RailsAuthorize
  module Matchers
    class Configuration
      attr_accessor :user_alias

      def initialize
        @user_alias = :user
      end
    end

    class << self
      def configure
        yield(configuration)
      end

      def configuration
        @configuration ||= RailsAuthorize::Matchers::Configuration.new
      end
    end
  end
end

if defined?(RailsAuthorize)
  RSpec.configure do |config|
    config.include RailsAuthorize::Matchers
  end
end
