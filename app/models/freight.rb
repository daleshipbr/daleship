class Freight < ApplicationRecord
  belongs_to :origin_port, class_name: "Port"
  belongs_to :destination_port, class_name: "Port"
  belongs_to :user
end
