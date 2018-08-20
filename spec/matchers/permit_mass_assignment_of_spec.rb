RSpec.describe 'permit_mass_assignment_of matcher' do
  context 'when no action is specified' do
    context 'when all the attributes are permitted' do
      subject { stubbed_policy(permitted_attributes: %i[foo bar]) }

      it { is_expected.to permit_mass_assignment_of(%i[foo bar]) }
      it { is_expected.to permit_mass_assignment_of(%i[foo]) }
      it { is_expected.to permit_mass_assignment_of(:foo) }
      it { is_expected.not_to permit_mass_assignment_of(:baz) }
      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar baz]) }
    end

    context 'when only one attribute is permitted' do
      subject { stubbed_policy(permitted_attributes: %i[foo]) }

      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar]) }
      it { is_expected.not_to permit_mass_assignment_of(%i[bar]) }
      it { is_expected.not_to permit_mass_assignment_of(:bar) }
      it { is_expected.to permit_mass_assignment_of(%i[foo]) }
      it { is_expected.to permit_mass_assignment_of(:foo) }
    end

    context 'when all the attributes are not permitted' do
      subject { stubbed_policy(permitted_attributes: %i[]) }

      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar]) }
      it { is_expected.not_to permit_mass_assignment_of(%i[foo]) }
      it { is_expected.not_to permit_mass_assignment_of(:foo) }
      it { is_expected.not_to permit_mass_assignment_of(:baz) }
    end
  end

  context 'when action is specified' do
    let(:action) { :action }

    context 'when all the attributes are permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[foo bar]) }

      it { is_expected.to permit_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.to permit_mass_assignment_of(%i[foo]).for_action(action) }
      it { is_expected.to permit_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(:baz).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar baz]).for_action(action) }
    end

    context 'when only one attribute is permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[foo]) }

      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.to permit_mass_assignment_of(%i[foo]).for_action(action) }
      it { is_expected.to permit_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(:baz).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar baz]).for_action(action) }
    end

    context 'when no attributes are permitted for the action' do
      subject { stubbed_policy("permitted_attributes_for_#{action}" => %i[]) }

      it { is_expected.not_to permit_mass_assignment_of(%i[foo bar]).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(%i[foo]).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(:foo).for_action(action) }
      it { is_expected.not_to permit_mass_assignment_of(:baz).for_action(action) }
    end
  end
end
