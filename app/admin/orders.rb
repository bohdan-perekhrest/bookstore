# frozen_string_literal: true

ActiveAdmin.register Order do
  config.clear_action_items!
  actions :index, :edit
  permit_params :status

  filter :status,
         as: :select,
         label: 'Status',
         collection: Order.statuses.keys

  index do
    column :id
    column 'Creation Date', :updated_at
    column :status
    actions
  end

  form do |f|
    f.inputs 'Order' do
      f.input :status, as: :select, collection: Order.statuses.keys
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.where.not(status: :in_progress)
    end
  end
end
