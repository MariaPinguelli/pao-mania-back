class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  has_many :order_items
  has_many :orders, through: :order_items

  # validar o formato de preço como número positivo
  validates :price, format: { with: /\A\d+(?:\.\d{0,2})?\z/, message: "must be a positive number with up to two decimal places" }
end
