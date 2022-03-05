namespace :book_store do
  desc "delete empty orders"
  task delete_empty_orders: :environment do
    Order.delete Order.where(total_price: nil).where("updated_at < ?", (DateTime.now() - 1.days))
  end
  task delete_abandoned_sessions: :enviroment do
    Order.delete Order.where("updated_at < ?", (DateTime.now - 1.days))
  end
end
