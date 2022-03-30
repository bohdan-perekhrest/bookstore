require 'rails_helper'

describe 'AddressPolicy' do
  subject { described_class.new(user, address) }

  let(:address) { FactoryBot.create(:address) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:read) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end

  context 'being an authorized user' do
    let(:user) { FactoryBot.create(:user) }

    it { is_expected.to permit_actions([:read, :create, :update]) }
  end
end