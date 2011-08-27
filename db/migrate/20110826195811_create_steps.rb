class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :trip_id
      t.datetime :arrival
      t.datetime :departure
      t.text :description
      t.string :location
      t.float :lat
      t.float :lng
      t.text :travel_info

      t.timestamps
    end
  end
end
