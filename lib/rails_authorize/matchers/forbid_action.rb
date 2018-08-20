module RailsAuthorize
  module Matchers
    extend RSpec::Matchers::DSL

    matcher :forbid_action do |action, *args|
      match do |policy|
        !policy.public_send("#{action}?", *args)
      end

      failure_message do |policy|
        "#{policy.class} does not forbid #{action} for " +
          policy.public_send(RailsAuthorize::Matchers.configuration.user_alias)
                .inspect + '.'
      end

      failure_message_when_negated do |policy|
        "#{policy.class} does not permit #{action} for " +
          policy.public_send(RailsAuthorize::Matchers.configuration.user_alias)
                .inspect + '.'
      end
    end
  end
end
