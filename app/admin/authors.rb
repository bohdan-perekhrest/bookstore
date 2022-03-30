ActiveAdmin.register Author do
  permit_params :first_name, :last_name, :description

  index do
    column :first_name
    column :last_name
    column :description do |author|
      truncate(author.description, length: 200)
    end
    actions
  end

  form html: { multipart: true } do |f|
    f.inputs 'Author' do
      f.input :first_name
      f.input :last_name
      f.input :description, as: :simplemde_editor
    end
    f.actions
  end
end
