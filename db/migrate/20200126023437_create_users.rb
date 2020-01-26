class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :job_title, null: false
      t.string :user_type, null: false
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
