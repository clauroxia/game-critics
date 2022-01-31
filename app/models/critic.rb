class Critic < ApplicationRecord
  # Validations
  validates :title, :body, presence: true

  # Associations
  belongs_to :user
  belongs_to :criticable, polymorphic: true, counter_cache: true
end
