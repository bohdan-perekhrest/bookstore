# frozen_string_literal: true

ActiveAdmin.register Book do
  includes :authors
  permit_params :name, :price, :description, :image, :category_id, :published_at, :height, :width, :depth, :materials,
                author_ids: [], small_images: []

  index do
    column 'Image' do |book|
      image_tag book.image, width: '50px'
    end
    column :category
    column :name
    column :authors
    column :description do |book|
      truncate(book.description, length: 200)
    end
    column :price
    actions
  end

  form html: { multipart: true } do |f|
    f.inputs 'Book' do
      f.input :name
      f.input :price
      f.input :description, as: :simplemde_editor
      f.input :category_id, as: :select, collection: Category.all, include_blank: false
      f.input :authors, as: :select, input_html: { multiple: true },
                        collection: Author.all.collect { |a| ["#{a.first_name} #{a.last_name}", a.id] }
      f.inputs 'Image' do
        f.input :image, as: :file
      end
      f.inputs 'Small images' do
        f.input :small_images, as: :file, input_html: { multiple: true }
      end
      f.input :published_at, as: :select, collection: (1900..Time.zone.now.year).to_a
      f.input :height
      f.input :width
      f.input :depth
      f.input :materials
    end
    f.actions
  end
end
