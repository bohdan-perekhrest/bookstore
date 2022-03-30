ActiveAdmin.register Coupon do
  permit_params :code, :value

  index do
    column :code
    column :value
    actions
  end

  form html: { multipart: true } do |f|
    f.inputs 'Coupon' do
      f.input :code
      f.input :value, type: 'number'
    end
    f.actions
  end
end