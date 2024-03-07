class Agent < ApplicationRecord
  has_many :supervisions
  has_many :supervisors, through: :supervisions
end
