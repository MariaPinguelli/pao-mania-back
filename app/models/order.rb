class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  # Calcular o preço total ao criar o pedido
  before_save :calculate_total_price


  def calculate_total_price
    self.total_price = order_items.sum { |item| item.quantity * item.product.price }
  end
end
