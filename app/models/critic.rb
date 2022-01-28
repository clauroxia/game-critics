class Critic < ApplicationRecord
  validates :title, :body, presence: true

  belongs_to :criticable, polymorphic: true, counter_cache: true
end
