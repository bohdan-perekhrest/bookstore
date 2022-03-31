require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { described_class.new(user) }

  context 'Address Policy' do
    context 'being a visitor' do
      let(:user) { nil }

      it { is_expected.to_not be_able_to(:read, Address) }
      it { is_expected.to_not be_able_to(:create, Address) }
      it { is_expected.to_not be_able_to(:update, Address) }
    end

    context 'being an authorized user' do
      let(:user) { FactoryBot.create(:user) }

      it { is_expected.to be_able_to(:read, Address) }
      it { is_expected.to be_able_to(:create, Address) }
      it { is_expected.to be_able_to(:update, Address) }
    end
  end

  context 'CreditCard Policy' do
    context 'being a visitor' do
      let(:user) { nil }

      it { is_expected.to_not be_able_to(:read, CreditCard) }
      it { is_expected.to_not be_able_to(:update, CreditCard) }
      it { is_expected.to_not be_able_to(:create, CreditCard) }
    end

    context 'being an authorized user' do
      let(:user) { FactoryBot.create(:user) }

      it { is_expected.to be_able_to(:read, CreditCard) }
      it { is_expected.to be_able_to(:update, CreditCard) }
      it { is_expected.to be_able_to(:create, CreditCard) }
    end
  end
  context 'Review Policy' do
    context 'being a visitor' do
      let(:user) { nil }

      it { is_expected.to be_able_to(:read, Review) }
      it { is_expected.to_not be_able_to(:create, Review) }
    end

    context 'being an authorized user' do
      let(:user) { FactoryBot.create(:user) }

      it { is_expected.to be_able_to(:read, Review) }
      it { is_expected.to be_able_to(:create, Review) }
    end
  end
end