class Freight < ApplicationRecord
  belongs_to :origin_port
  belongs_to :destination_port
  belongs_to :user
end
