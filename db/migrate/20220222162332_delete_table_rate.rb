class DeleteTableRate < ActiveRecord::Migration[6.1]
  def change
    drop_table :rates
  end
end
