RSpec.describe 'forbid_action matcher' do
  context 'when no optional arguments are specified' do
    context 'when action is permitted' do
      subject { stubbed_policy(action?: true) }
      it { is_expected.not_to forbid_action(:action) }
    end

    context 'when action is forbidden' do
      subject { stubbed_policy(action?: false) }
      it { is_expected.to forbid_action(:action) }
    end
  end

  context 'when arguments are specified' do
    let(:correct_value) { 'argument' }

    context 'when action is permitted' do
      let(:action) do
        proc do |argument|
          raise unless argument == correct_value
          true
        end
      end

      subject { stubbed_policy(action?: action) }
      it { is_expected.not_to forbid_action(:action, correct_value) }
    end

    context 'when action is not permitted' do
      let(:action) do
        proc do |argument|
          raise unless argument == correct_value
          false
        end
      end

      subject { stubbed_policy(action?: action) }
      it { is_expected.to forbid_action(:action, correct_value) }
    end
  end
end
