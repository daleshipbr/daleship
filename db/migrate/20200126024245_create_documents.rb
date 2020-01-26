class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.reference :booking
      t.string :file_url
      t.boolean :approved
      t.string :type

      t.timestamps
    end
  end
end
