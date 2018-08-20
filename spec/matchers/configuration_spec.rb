RSpec.describe RailsAuthorize::Matchers, '.configuration#user_alias' do
  context 'when value is set' do
    let(:value) { :account }

    before do
      RailsAuthorize::Matchers.configure do |config|
        config.user_alias = value
      end
    end

    subject { RailsAuthorize::Matchers.configuration.user_alias }
    it { is_expected.to eq(value) }
  end
end
