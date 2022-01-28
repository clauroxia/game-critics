class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game
end
