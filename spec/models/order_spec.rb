require 'rails_helper'

RSpec.describe Order, type: :model do
  it { expect(subject).to have_many :order_items }

  it 'update subtotal before save' do
    allow(subject).to receive(:order_items) { [FactoryBot.build(:order_item, :with_book)] }
    allow_any_instance_of(Book).to receive(:price).and_return 12.30
    allow_any_instance_of(OrderItem).to receive(:quantity).and_return 4
    subject.send(:update_subtotal)
    expect(subject.subtotal).to eq 49.20
  end

  describe 'scopes' do
    before(:all) do
      @order = FactoryBot.create(:order, :in_progress)
      @wrong_ids = []
      2.times { @wrong_ids << FactoryBot.create(:order, :delivered).id }
    end

    context 'order_id where status in progress' do
      it 'finds order_id with status in_progress' do
        user = @order.user
        FactoryBot.create_list(:order, 2, :in_queue, user: user)
        expect(user.orders.where(status: :in_progress).first.id).to eq @order.id
      end

      it 'not eq other status' do
        expect(@wrong_ids).not_to include Order.in_progress
      end
    end

    context 'finds proper status' do
      it 'find only in_progress' do
        expect(Order.where(status: :in_progress).first.status).to eq 'in_progress'
      end

      let(:statuses) { Order.where(status: :delivered).map(&:status) }

      it 'contain only one type of statuses'do
        expect(statuses.uniq.size).to eq 1
      end

      it 'contain only one type of statuses'do
        expect(statuses.uniq).to eq ['delivered']
      end
    end
  end

  describe 'public methods' do
    context 'responds to its methods' do
      it { expect(subject).to respond_to(:subtotal) }
      it { expect(subject).to respond_to(:discount) }
      it { expect(subject).to respond_to(:finalize) }
      it { expect(subject).to respond_to(:total) }
    end

    describe '#discount' do
      let(:order) { FactoryBot.create(:order, coupon: coupon) }

      context 'when apply coupon' do
        let(:coupon) { FactoryBot.create(:coupon, value: 7.00) }
        it 'return amount of discount' do
          expect(order.discount).to eq 7.00
        end
      end

      context 'when no coupon' do
        let(:coupon) { nil }

        it 'return zero' do
          expect(order.discount).to eq 0.00
        end
      end
    end

    describe '#subtotal' do
      let(:book) { FactoryBot.create(:book, cost: 3.5) }
      let(:order_item) { FactoryBot.create(:order_item, book: book, quantity: 2) }

      it 'sum all items in order' do
        subject =  FactoryBot.build(:order, order_items: [order_item])
        expect(subject.subtotal.to_f).to eq 7.0
      end
    end

    describe '#finalize' do
      let(:order_in_progress) { FactoryBot.create(:order, :in_progress) }

      it { expect(order_in_progress.status).to eq 'in_progress' }

      it 'change status to "in_queue"' do
        order_in_progress.finalize
        expect(order_in_progress.status).to eq 'in_queue'
      end
    end
  end
end
