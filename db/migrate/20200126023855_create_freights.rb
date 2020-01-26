class CreateFreights < ActiveRecord::Migration[6.0]
  def change
    create_table :freights do |t|
      t.string :modal, null: false
      t.references :origin_port, foreign_key: { to_table: :ports }, null: false, index: true
      t.references :destination_port, null: false, foreign_key: { to_table: :ports }, index: true
      t.string :load_type, null: false
      t.string :shipment_type, null: false
      t.string :container_pack, null: false
      t.references :user, null: false, foreign_key: true
      t.date :expiration_date, null: false
      t.integer :price_per_container, null: false
      t.string :ship_owner, null: false

      t.timestamps
    end
  end
end
