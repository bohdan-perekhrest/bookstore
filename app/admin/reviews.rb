# frozen_string_literal: true

ActiveAdmin.register Review do
  actions :all, except: %i[new create destroy]
  filter :status,
         as: :select,
         label: 'Status'

  permit_params :title, :text, :user_id, :book_id, :star, :status

  index do
    column :book
    column :title
    column :created_at
    column :user
    column :status
    actions
  end
end
