module RailsAuthorize
  module Matchers
    extend RSpec::Matchers::DSL

    matcher :permit_actions do |actions|
      match do |policy|
        return false if actions.count < 1
        @forbidden_actions = actions.reject do |action|
          policy.public_send("#{action}?")
        end
        @forbidden_actions.empty?
      end

      attr_reader :forbidden_actions

      zero_actions_failure_message = 'At least one action must be specified ' \
        'when using the permit_actions matcher.'

      failure_message do |policy|
        if actions.count.zero?
          zero_actions_failure_message
        else
          "#{policy.class} expected to permit #{actions}, but forbade " \
            "#{forbidden_actions} for " +
            policy.public_send(RailsAuthorize::Matchers.configuration.user_alias)
                  .inspect + '.'
        end
      end

      failure_message_when_negated do |policy|
        if actions.count.zero?
          zero_actions_failure_message
        else
          "#{policy.class} expected to forbid #{actions}, but allowed " \
            "#{forbidden_actions} for " +
            policy.public_send(RailsAuthorize::Matchers.configuration.user_alias)
                  .inspect + '.'
        end
      end
    end
  end
end
