class Transaction < ApplicationRecord
  belongs_to :tipee
  belongs_to :tipper
end
