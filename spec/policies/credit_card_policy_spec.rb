require 'rails_helper'

describe CreditCardPolicy do
  subject { described_class.new(user, credit_card) }

  let(:credit_card) { create(:credit_card) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_action(:read) }
    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
  end

  context 'being an authorized user' do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions([:read, :create, :update]) }
  end
end