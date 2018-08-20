RSpec.describe 'permit_action matcher' do
  context 'when no arguments are specified' do
    context 'when action is permitted' do
      subject { stubbed_policy(test?: true) }
      it { is_expected.to permit_action(:test) }
    end

    context 'when action is forbidden' do
      subject { stubbed_policy(test?: false) }
      it { is_expected.not_to permit_action(:test) }
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
      it { is_expected.to permit_action(:action, correct_value) }
    end

    context 'when action is forbidden' do
      let(:action) do
        proc do |argument|
          raise unless argument == correct_value
          false
        end
      end

      subject { stubbed_policy(action?: action) }
      it { is_expected.not_to permit_action(:action, correct_value) }
    end
  end
end
