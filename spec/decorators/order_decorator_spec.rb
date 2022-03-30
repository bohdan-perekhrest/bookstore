# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderDecorator do
  subject { FactoryBot.create(:order, updated_at: '2017-08-15 12:00:00', id: 147803).decorate }
  describe '#complited_at' do
    it 'format time for order' do
      expect(subject.complited_at).to eq '2017-08-15'
    end
  end

  describe '#number' do
    it 'make apropriate Number for order' do
      expect(subject.number).to eq 'R00147803'
    end
  end

  describe '#status' do
    it 'show right status' do
      order = FactoryBot.create(:order, status: :in_progress).decorate
      expect(order.status).to eq 'in_progress'
    end
  end
end
