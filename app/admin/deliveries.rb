ActiveAdmin.register Delivery do
  permit_params :name, :duration, :price

  index do
    column :name
    column :duration
    column :price
    actions
  end

  form html: { multipart: true } do |f|
    f.inputs 'Delivery' do
      f.input :name
      f.input :duration
      f.input :price, type: 'number'
    end
    f.actions
  end
end
