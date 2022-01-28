class Company < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  # validates :cover, presence: true

  # Associations
  has_one_attached :cover, dependent: :destroy
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies, dependent: :nullify
  has_many :critics, as: :criticable, dependent: :destroy
end
