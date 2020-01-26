class Booking < ApplicationRecord
  belongs_to :freight
  belongs_to :user
end
