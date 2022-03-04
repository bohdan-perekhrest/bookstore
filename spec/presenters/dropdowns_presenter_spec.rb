# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DropdownsPresenter do
  let(:view) { ActionController::Base.new.view_context }

  context '#main_text' do
    let(:filter) { :popular }
    let(:dropdowns_presenter) { DropdownsPresenter.new(filter) }
    let(:dropdowns_presenter_empty) { DropdownsPresenter.new(nil) }
    let(:result) { 'Popular first' }
    let(:result_empty) { 'Newest first' }

    it 'should return :popular for users' do
      expect(dropdowns_presenter.main_text).to eq(result)
    end

    it 'should return default' do
      expect(dropdowns_presenter_empty.main_text).to eq(result_empty)
    end
  end

  context '#main_text_order' do
    let(:filter) { :in_delivery }
    let(:dropdowns_presenter) { DropdownsPresenter.new(filter) }
    let(:dropdowns_presenter_empty) { DropdownsPresenter.new(nil) }
    let(:result) { 'In Delivery' }
    let(:result_empty) { 'All Orders' }

    it 'should return :popular for users' do
      expect(dropdowns_presenter.main_text_order).to eq(result)
    end

    it 'should return default' do
      expect(dropdowns_presenter_empty.main_text_order).to eq(result_empty)
    end
  end
end

