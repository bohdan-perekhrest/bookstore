require 'spec_helper'

RSpec.describe OrderQuery do
  before do
    @user = FactoryBot.create(:user)
    15.times { FactoryBot.create(:order, :with_order_item, user: @user)}
  end

  subject { OrderQuery.new }

  context '#by_filter' do
    it 'unless give set to query it will work with all Orders' do
      expect(subject.relation).to eq Order.all
    end

    %w[all in_queue in_delivery canceled delivered].each do |method|
      it "call #{method} when receive params '#{method}'" do
        expect(subject).to receive(method)
        subject.send(method)
      end
    end
  end
end

