class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :email
      t.string :name
      t.text :description
      t.string :marketable_url

      t.timestamps
    end
  end
end
