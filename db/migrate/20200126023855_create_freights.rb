class CreateFreights < ActiveRecord::Migration[6.0]
  def change
    create_table :freights do |t|
      t.string :modal
      t.references :origin_port, null: false, foreign_key: true
      t.references :destination_port, null: false, foreign_key: true
      t.string :load_type
      t.string :shipment_type
      t.string :container_pack
      t.references :user, null: false, foreign_key: true
      t.date :expiration_date
      t.integer :price_per_container
      t.string :ship_owner

      t.timestamps
    end
  end
end
