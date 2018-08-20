RSpec.describe 'forbid_actions matcher' do
  context 'when no actions are specified' do
    subject { stubbed_policy }

    it { is_expected.not_to forbid_actions([]) }
  end

  context 'when one action is specified' do
    context 'when is permitted' do
      subject { stubbed_policy(action?: true) }

      it { is_expected.not_to forbid_actions([:action]) }
    end

    context 'when is forbidden' do
      subject { stubbed_policy(action?: false) }

      it { is_expected.to forbid_actions([:action]) }
    end
  end

  context 'when more than one action is specified' do
    context 'when all are permitted' do
      subject { stubbed_policy(action1?: true, action2?: true) }

      it { is_expected.not_to forbid_actions(%i[action1 action2]) }
    end

    context 'when all are forbidden' do
      subject { stubbed_policy(action1?: false, action2?: false) }

      it { is_expected.to forbid_actions(%i[action1 action2]) }
    end

    context 'when one is permitted and another forbidden' do
      subject { stubbed_policy(action1?: true, action2?: false, user: nil) }

      it { is_expected.not_to forbid_actions(%i[action1 action2]) }
    end
  end
end
