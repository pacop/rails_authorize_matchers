RSpec.describe 'forbid_mass_assignment_of matcher' do
  context 'when action is not specified' do
    context 'when attributes are permitted' do
      subject { stubbed_policy(permitted_attributes: %i[foo bar]) }

      it { is_expected.not_to forbid_mass_assignment_of(%i[foo bar]) }
      it { is_expected.not_to forbid_mass_assignment_of(%i[foo]) }
      it { is_expected.not_to forbid_mass_assignment_of(:foo) }
      it { is_expected.to forbid_mass_assignment_of(%i[baz]) }
      it { is_expected.to forbid_mass_assignment_of(:baz) }
    end

    context 'when only one attribute is permitted' do
      subject { stubbed_policy(permitted_attributes: %i[foo]) }

      it { is_expected.not_to forbid_mass_assignment_of(%i[foo bar]) }
      it { is_expected.to forbid_mass_assignment_of(%i[bar]) }
      it { is_expected.to forbid_mass_assignment_of(:bar) }
      it { is_expected.not_to forbid_mass_assignment_of(%i[foo]) }
      it { is_expected.not_to forbid_mass_assignment_of(:foo) }
    end

    context 'when no attributes are not permitted' do
      subject { stubbed_policy(permitted_attributes: %i[]) }

      it { is_expected.to forbid_mass_assignment_of(%i[foo bar]) }
      it { is_expected.to forbid_mass_assignment_of(%i[foo]) }
      it { is_expected.to forbid_mass_assignment_of(:foo) }
      it { is_expected.to forbid_mass_assignment_of(:baz) }
    end
  end

  context 'when action is specified' do
    let(:action) { :action }

    context 'when attributes are permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[foo bar]) }

      it { is_expected.not_to forbid_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.not_to forbid_mass_assignment_of(%i[foo]).for_action(action) }
      it { is_expected.not_to forbid_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(%i[baz]).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(:baz).for_action(action) }
    end

    context 'when only one attribute is permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[foo]) }

      it { is_expected.not_to forbid_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.not_to forbid_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(%i[bar]).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(%i[baz]).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(:baz).for_action(action) }
    end

    context 'when no attributes are not permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[]) }

      it { is_expected.to forbid_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(%i[foo]).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.to forbid_mass_assignment_of(:baz).for_action(action) }
    end
  end
end
