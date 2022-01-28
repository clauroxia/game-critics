class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :games
end
