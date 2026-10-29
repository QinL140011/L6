class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product
  validates :qty, numericality: { greater_than: 0 }
end
