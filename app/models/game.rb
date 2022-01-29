class Game < ApplicationRecord
  # Validations
  validates :name, presence: true, uniqueness: true
  validates :rating,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 },
            allow_nil: true
  validates :cover, presence: true
  validates :parent,
            inclusion: { in: proc { Game.main_game }, message: "It's not a valid Game" },
            unless: proc { main_game? || category.nil? }
  validates :parent, absence: true, if: proc { main_game? }

  # Enum
  enum category: { main_game: 0, expansion: 1 }

  # Associations
  belongs_to :parent, class_name: "Game", optional: true
  has_many :expansions, {
    class_name: "Game",
    foreign_key: "parent_id",
    dependent: :nullify,
    inverse_of: "parent"
  }
  has_one_attached :cover, dependent: :destroy

  has_and_belongs_to_many :genres
  has_and_belongs_to_many :platforms

  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy
end
