class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "não é válido" }
  has_many :orders
  has_many :order_items, through: :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
