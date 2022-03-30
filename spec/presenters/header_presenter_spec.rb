# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HeaderPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:order) { FactoryBot.create(:order, :with_order_item) }

  context '#order_items_count' do
    let(:header_presenter) { HeaderPresenter.new(order.id) }

    it 'should return count of order items in order' do
      expect(header_presenter.order_items_count).to eq(2)
    end
  end
end

