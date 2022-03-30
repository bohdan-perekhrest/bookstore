require 'rails_helper'

describe ReviewPolicy do
  subject { described_class.new(user, review) }

  let(:review) { create(:review) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:create) }
  end

  context 'being an authorized user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions([:show, :create]) }
  end
end