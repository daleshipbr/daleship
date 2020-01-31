class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :remenber_digest, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :reset_digest, :string
    add_column :users, :reset_sent_at, :datetime
    add_column :users, :accepted_terms_of_service, :boolean
    add_column :users, :destroyed_at, :datetime
  end
end
