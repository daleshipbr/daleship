class CreatePorts < ActiveRecord::Migration[6.0]
  def change
    create_table :ports do |t|
      t.string :name
      t.string :zipcode
      t.string :street
      t.integer :number
      t.string :complement
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
