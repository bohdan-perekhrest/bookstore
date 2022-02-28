class CreateRate < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.belongs_to :rater
      t.belongs_to :rateable, polymorphic: true
      t.integer :stars
      t.timestamps
    end
    add_index :rates, [:rateable_id, :rateable_type]
  end
end

