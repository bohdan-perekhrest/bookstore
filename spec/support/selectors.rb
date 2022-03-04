# frozen_string_literal: true

include Rails.application.routes.url_helpers

module Selectors
  Capybara.add_selector(:linkhref) do
    xpath {|href| ".//a[@href='#{href}']"}
  end

  Capybara.add_selector(:shopping_cart_icon) do
    xpath {|book_id| ".//a[@href='#{order_items_path(order_item: {quantity: 1, book_id: book_id})}']"}
  end

  Capybara.add_selector(:filter_by_category) do
    xpath {|cat_id| ".//a[@href='#{books_path(category_id: cat_id)}']"}
  end

  Capybara.add_selector(:log_out) do
    xpath {".//div[@class='hidden-xs']//a[@href='/users/sign_out']"}
  end
end
