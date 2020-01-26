class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.references :freight, null: false, foreign_key: true
      t.date :load_date
      t.integer :containers
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
