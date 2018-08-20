module Helpers
  def stubbed_policy(args=[])
    policy = double
    args.each do |key, value|
      if value.respond_to?(:call)
        allow(policy).to receive(key) { |args| value.call(*args) }
      else
        allow(policy).to receive(key).and_return(value)
      end
    end
    policy
  end
end
