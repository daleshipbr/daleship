class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.references :booking, null: false, foreign_key: true
      t.string :file_url
      t.boolean :approved
      t.string :type

      t.timestamps
    end
  end
end
