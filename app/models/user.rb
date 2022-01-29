class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }

  # Association
  has_many :critics, dependent: :destroy
end
