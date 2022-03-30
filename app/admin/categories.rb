ActiveAdmin.register Category do
  permit_params :name

  index do
    column :name
    actions
  end

  form html: { multipart: true } do |f|
    f.inputs 'Category' do
      f.input :name
    end
    f.actions
  end
end
