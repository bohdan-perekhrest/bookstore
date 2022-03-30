# frozen_string_literal: true

ActiveAdmin.register Review do
  actions :all, except: %i[new create destroy]
  filter :status,
         as: :select,
         label: 'Status',
         collection: Review.statuses.keys

  permit_params :title, :text, :user_id, :book_id, :star, :status

  index do
    column :book
    column :title
    column :created_at
    column :user
    column :status
    actions
  end

  form do |f|
    f.inputs 'Review' do
      f.input :title
      f.input :text
      f.input :status, as: :select, collection: Review.statuses.keys
    end
    f.actions
  end
end
